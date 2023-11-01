Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953BC7DE142
	for <lists+linux-arch@lfdr.de>; Wed,  1 Nov 2023 14:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343681AbjKANAn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Nov 2023 09:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343771AbjKANAm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Nov 2023 09:00:42 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B422B7;
        Wed,  1 Nov 2023 06:00:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VvSkNtA_1698843627;
Received: from 30.240.99.237(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0VvSkNtA_1698843627)
          by smtp.aliyun-inc.com;
          Wed, 01 Nov 2023 21:00:28 +0800
Message-ID: <57617a1a-15ab-4c08-bcdf-ff0ff9bbaf96@linux.alibaba.com>
Date:   Wed, 1 Nov 2023 21:00:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Sharing page tables across processes (mshare)
Content-Language: en-US
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>,
        Mark Hemment <markhemm@googlemail.com>
References: <4082bc40-a99a-4b54-91e5-a1b55828d202@oracle.com>
 <3bbdc5de-ce97-4a4d-b420-1605cef3ffcd@linux.alibaba.com>
 <18d80012-193b-47cf-ab75-794c5730aa71@oracle.com>
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <18d80012-193b-47cf-ab75-794c5730aa71@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 2023/11/1 07:01, Khalid Aziz wrote:
> On 10/29/23 20:45, Rongwei Wang wrote:
>>
>>
>> On 2023/10/24 06:44, Khalid Aziz wrote:
>>> Threads of a process share address space and page tables that allows 
>>> for
>>> two key advantages:
>>>
>>> 1. Amount of memory required for PTEs to map physical pages stays low
>>> even when large number of threads share the same pages since PTEs are
>>> shared across threads.
>>>
>>> 2. Page protection attributes are shared across threads and a change
>>> of attributes applies immediately to every thread without any overhead
>>> of coordinating protection bit changes across threads.
>>>
>>> These advantages no longer apply when unrelated processes share pages.
>>> Some applications can require 1000s of processes that all access the
>>> same set of data on shared pages. For instance, a database server may
>>> map in a large chunk of database into memory to provide fast access to
>>> data to the clients using buffer cache. Server may launch new processes
>>> to provide services to new clients connecting to the shared database.
>>> Each new process will map in the shared database pages. When the PTEs
>>> for mapping in shared pages are not shared across processes, each
>>> process will consume some memory to store these PTEs. On x86_64, each
>>> page requires a PTE that is only 8 bytes long which is very small
>>> compared to the 4K page size. When 2000 processes map the same page in
>>> their address space, each one of them requires 8 bytes for its PTE and
>>> together that adds up to 8K of memory just to hold the PTEs for one 4K
>>> page. On a database server with 300GB SGA, a system crash was seen with
>>> out-of-memory condition when 1500+ clients tried to share this SGA even
>>> though the system had 512GB of memory. On this server, in the worst 
>>> case
>>> scenario of all 1500 processes mapping every page from SGA would have
>>> required 878GB+ for just the PTEs. If these PTEs could be shared, 
>>> amount
>>> of memory saved is very significant.
>>>
>>> When PTEs are not shared between processes, each process ends up with
>>> its own set of protection bits for each shared page. Database servers
>>> often need to change protection bits for pages as they manipulate and
>>> update data in the database. When changing page protection for a shared
>>> page, all PTEs across all processes that have mapped the shared page in
>>> need to be updated to ensure data integrity. To accomplish this, the
>>> process making the initial change to protection bits sends messages to
>>> every process sharing that page. All processes then block any access to
>>> that page, make the appropriate change to protection bits, and send a
>>> confirmation back.  To ensure data consistency, access to shared page
>>> can be resumed when all processes have acknowledged the change. This is
>>> a disruptive and expensive coordination process. If PTEs were shared
>>> across processes, a change to page protection for a shared PTE becomes
>>> applicable to all processes instantly with no coordination required to
>>> ensure consistency. Changing protection bits across all processes
>>> sharing database pages is a common enough operation on Oracle databases
>>> that the cost is significant and cost goes up with the number of 
>>> clients.
>>>
>>> This is a proposal to extend the same model of page table sharing for
>>> threads across processes. This will allow processes to tap into the
>>> same benefits that threads get from shared page tables,
>>>
>>> Sharing page tables across processes opens their address spaces to each
>>> other and thus must be done carefully. This proposal suggests sharing
>>> PTEs across processes that trust each other and have explicitly agreed
>>> to share page tables. The proposal is to add a new flag to mmap() 
>>> call -
>>> MAP_SHARED_PT.  This flag can be specified along with MAP_SHARED by a
>>> process to hint to kernel that it wishes to share page table entries
>>> for this file mapping mmap region with other processes. Any other 
>>> process
>>> that mmaps the same file with MAP_SHARED_PT flag can then share the 
>>> same
>>> page table entries. Besides specifying MAP_SHARED_PT flag, the processe
>>> must map the files at a PMD aligned address with a size that is a
>>> multiple of PMD size and at the same virtual addresses. NOTE: This
>>> last requirement of same virtual addresses can possibly be relaxed if
>>> that is the consensus.
>>>
>>> When mmap() is called with MAP_SHARED_PT flag, a new host mm struct
>>> is created to hold the shared page tables. Host mm struct is not
>>> attached to a process. Start and size of host mm are set to the
>>> start and size of the mmap region and a VMA covering this range is
>>> also added to host mm struct. Existing page table entries from the
>>> process that creates the mapping are copied over to the host mm
>>> struct. All processes mapping this shared region are considered
>>> guest processes. When a guest process mmap's the shared region, a vm
>>> flag VM_SHARED_PT is added to the VMAs in guest process. Upon a page
>>> fault, VMA is checked for the presence of VM_SHARED_PT flag. If the
>>> flag is found, its corresponding PMD is updated with the PMD from
>>> host mm struct so the PMD will point to the page tables in host mm
>>> struct.  When a new PTE is created, it is created in the host mm struct
>>> page tables and the PMD in guest mm points to the same PTEs.
>>>
>>>
>>> --------------------------
>>> Evolution of this proposal
>>> --------------------------
>>>
>>> The original proposal -
>>> <https://lore.kernel.org/lkml/cover.1642526745.git.khalid.aziz@oracle.com/>, 
>>>
>>> was for an mshare() system call that a donor process calls to create
>>> an empty mshare'd region. This shared region is pgdir aligned and
>>> multiple of pgdir size. Each mshare'd region creates a corresponding
>>> file under /sys/fs/mshare which can be read to get information on
>>> the region.  Once an empty region has been created, any objects can
>>> be mapped into this region and page tables for those objects will be
>>> shared.  Snippet of the code that a donor process would run looks
>>> like below:
>>>
>>>         addr = mmap((void *)TB(2), GB(512), PROT_READ | PROT_WRITE,
>>>                         MAP_SHARED | MAP_ANONYMOUS, 0, 0);
>>>         if (addr == MAP_FAILED)
>>>                 perror("ERROR: mmap failed");
>>>
>>>         err = syscall(MSHARE_SYSCALL, "testregion", (void *)TB(2),
>>>             GB(512), O_CREAT|O_RDWR|O_EXCL, 600);
>>>         if (err < 0) {
>>>                 perror("mshare() syscall failed");
>>>                 exit(1);
>>>         }
>>>
>>>         strncpy(addr, "Some random shared text",
>>>             sizeof("Some random shared text"));
>>>
>>>
>>> Snippet of code that a consumer process would execute looks like:
>>>
>>>         fd = open("testregion", O_RDONLY);
>>>         if (fd < 0) {
>>>                 perror("open failed");
>>>                 exit(1);
>>>         }
>>>
>>>         if ((count = read(fd, &mshare_info, sizeof(mshare_info)) > 0))
>>>                 printf("INFO: %ld bytes shared at addr %lx \n",
>>>                 mshare_info[1], mshare_info[0]);
>>>         else
>>>                 perror("read failed");
>>>
>>>         close(fd);
>>>
>>>         addr = (char *)mshare_info[0];
>>>         err = syscall(MSHARE_SYSCALL, "testregion", (void 
>>> *)mshare_info[0],
>>>             mshare_info[1], O_RDWR, 600);
>>>         if (err < 0) {
>>>                 perror("mshare() syscall failed");
>>>                 exit(1);
>>>         }
>>>
>>>         printf("Guest mmap at %px:\n", addr);
>>>         printf("%s\n", addr);
>>>     printf("\nDone\n");
>>>
>>>         err = syscall(MSHARE_UNLINK_SYSCALL, "testregion");
>>>         if (err < 0) {
>>>                 perror("mshare_unlink() failed");
>>>                 exit(1);
>>>         }
>>>
>>>
>>> This proposal evolved into completely file and mmap based API -
>>> <https://lore.kernel.org/lkml/cover.1656531090.git.khalid.aziz@oracle.com/>. 
>>>
>>> This new API looks like below:
>>>
>>> 1. Mount msharefs on /sys/fs/mshare -
>>>     mount -t msharefs msharefs /sys/fs/mshare
>>>
>>> 2. mshare regions have alignment and size requirements. Start
>>>    address for the region must be aligned to an address boundary and
>>>    be a multiple of fixed size. This alignment and size requirement
>>>    can be obtained by reading the file /sys/fs/mshare/mshare_info
>>>    which returns a number in text format. mshare regions must be
>>>    aligned to this boundary and be a multiple of this size.
>>>
>>> 3. For the process creating mshare region:
>>>     a. Create a file on /sys/fs/mshare, for example -
>>>         fd = open("/sys/fs/mshare/shareme",
>>>                 O_RDWR|O_CREAT|O_EXCL, 0600);
>>>
>>>     b. mmap this file to establish starting address and size -
>>>         mmap((void *)TB(2), BUF_SIZE, PROT_READ | PROT_WRITE,
>>>                         MAP_SHARED, fd, 0);
>>>
>>>     c. Write and read to mshared region normally.
>>>
>>> 4. For processes attaching to mshare'd region:
>>>     a. Open the file on msharefs, for example -
>>>         fd = open("/sys/fs/mshare/shareme", O_RDWR);
>>>
>>>     b. Get information about mshare'd region from the file:
>>>         struct mshare_info {
>>>             unsigned long start;
>>>             unsigned long size;
>>>         } m_info;
>>>
>>>         read(fd, &m_info, sizeof(m_info));
>>>
>>>     c. mmap the mshare'd region -
>>>         mmap(m_info.start, m_info.size,
>>>             PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>>>
>>> 5. To delete the mshare region -
>>>         unlink("/sys/fs/mshare/shareme");
>>>
>>>
>>>
>>> Further discussions over mailing lists and LSF/MM resulted in 
>>> eliminating
>>> msharefs and making this entirely mmap based -
>>> <https://lore.kernel.org/lkml/cover.1682453344.git.khalid.aziz@oracle.com/>. 
>>>
>>> With this change, if two processes map the same file with same
>>> size, PMD aligned address, same virtual address and both specify
>>> MAP_SHARED_PT flag, they start sharing PTEs for the file mapping.
>>> These changes eliminate support for any arbitrary objects being
>>> mapped in mshare'd region. The last implementation required sharing
>>> minimum PMD sized chunks across processes. These changes were
>>> significant enough to make this proposal distinct enough for me to
>>> use a new name - ptshare.
>>>
>>>
>>> ----------
>>> What next?
>>> ----------
>>>
>>> There were some more discussions on this proposal while I was on
>>> leave for a few months. There is enough interest in this feature to
>>> continue to refine this. I will refine the code further but before
>>> that I want to make sure we have a common understanding of what this
>>> feature should do.
>>>
>>> As a result of many discussions, a new distinct version of
>>> original proposal has evolved. Which one do we agree to continue
>>> forward with - (1) current version which restricts sharing to PMD sized
>>> and aligned file mappings only, using just a new mmap flag
>>> (MAP_SHARED_PT), or (2) original version that creates an empty page
>>> table shared mshare region using msharefs and mmap for arbitrary
>>> objects to be mapped into later?
>> Hi, Khalid
>>
>> I am unfamiliar to original version, but I can provide some feedback 
>> on the issues encountered
>> during the implementation of current version (mmap & MAP_SHARED_PT).
>> We realize our internal pgtable sharing version in the current 
>> method, but the codes
>> are a bit hack in some places, e.g. (1) page fault, need to switch 
>> original mm to flush TLB or
>> charge memcg; (2) shrink memory, a bit complicated to to handle pte 
>> entries like normal pte mapping;
>> (3) munmap/madvise support;
>>
>> If these hack codes can be resolved, the current method seems already 
>> simple and usable enough (just my humble opinion).
> Thanks for taking the time to review. Yes, the code could use some 
> improvement and I expect to do that as I get feedback. Can I ask you 
> what you mean by "internal pgtable sharing version"? Are you using the 
> patch I had sent out or a modified version of it on internal test 
> machines?
Yes, a modified version with functions mentioned in the previous mail 
based on your mmap(MAP_SHARED_PT) patchset. That realized in kernel-5.10.

And if everyone thinks it's helpful for this discussion, I can send it 
out next.
>
> Thanks,
> Khalid
>
>>
>>
>> And besides above issues, we (our internal version) do not care 
>> memory migration, compaction, etc,. I'm not sure what
>> functions pgtable sharing needs to support. Maybe we can have a 
>> discussion about that firstly, then decide
>> which one? Here are the things we support in pgtable sharing:
>>
>> a. share pgtables only between parent and child processes; > b. 
>> support anonymous shared memory and id-known (SYSV shared memory);
>> c. madvise(MADV_DONTNEED, MADV_DONTDUMP, MADV_DODUMP), DONTNEED 
>> supports 2M granularity;
>> d. reclaim pgtable sharing memory in shrinker;
>>
>> The above support is actually requested by our internal user. Plus, 
>> we skip memory migration, compaction, mprotect, mremap etc, directly.
>> IMHO, support all memory behavior likes normal pte mapping is 
>> unnecessary?
>> (Next, It seems I need to study your original version :-))
>>
>> Thanks,
>> -wrw
>>>
>>> Thanks,
>>> Khalid
>>

