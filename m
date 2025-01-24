Return-Path: <linux-arch+bounces-9888-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B219A1BF38
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2025 00:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B367B16E3BB
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2025 23:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805921F76CB;
	Fri, 24 Jan 2025 23:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E1xK9jEa"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644201F1912;
	Fri, 24 Jan 2025 23:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737762970; cv=none; b=LVI4CwAk+mLw29WiGmJyaGI0wGrQ9CsbtwAdBsGyrzaH+qA6t5Kmst2gMoAcR5TxLT5ZSZ7vEo3H3F7L8inpH2YoZPqitTkZeGu1OUE1yXxbErq4/bGK513IJ/eTs1MrSDAmIh2mh4csB2HXattV1Loc0a++fi1RVcv9rt15D3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737762970; c=relaxed/simple;
	bh=L8y56SjP7isqbwJy0XsaSlo7njKVytoDuH+VFtbpTlk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tUQXMyQB8aIYQ4MfnYtP6/D3ZUtMQoxMdlJfIRKATOVy2s3YhfPTsxdU63IUjkJ5FxYXGT2KbYsjtCFr+gg17/bueoSVjPEMbHWkgERIsdkcT/KWM77MFcp6BslaRCB+vsN1+gfEMRALW1SWS0vbBj8wURNJeMpxcA4AWrHGpx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E1xK9jEa; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OIBX64001521;
	Fri, 24 Jan 2025 23:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=OoqIIp07vVlV0ZvUYL5dFJsRdATud
	xy/ydIfUflIOgM=; b=E1xK9jEaNze7i3AjGB7Z0p4FscOcJKV+Mzhgz/QhHRxhH
	Nqy4iH32MG7SdHrjHbLmhPri3tBvopcC5ahw3kkFOSl1OBnsLSzFwWkjFiUffzOR
	eqxVlekh9XEKZQ9aYga6jycIsRKG0onBzVI1pXtLh1jLwo61oBsQ1PdE05Q0BJ7B
	nqJmFKr8wssFFeeuEjuZM2I6VTRtigU//laDtoypbcrN93HkvKWMUcwbfu3d6VTf
	LT56frNv7YoZwk3N5TGeUeTb+iOpxx2Fz4yNFcudVFjoP9Fvh3PO2E6FjRjgUJDF
	WbGopB+E471aLVhVcMu7nzdTayoC5YS5bM9MkeHyQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44b06j5j3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:55:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50OLP7ea036648;
	Fri, 24 Jan 2025 23:55:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44917u49yw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:55:00 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50ONsxPg018051;
	Fri, 24 Jan 2025 23:54:59 GMT
Received: from localhost.us.oracle.com (dhcp-10-65-130-174.vpn.oracle.com [10.65.130.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44917u49ww-1;
	Fri, 24 Jan 2025 23:54:59 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
To: akpm@linux-foundation.org, willy@infradead.org, markhemm@googlemail.com,
        viro@zeniv.linux.org.uk, david@redhat.com, khalid@kernel.org
Cc: anthony.yznaga@oracle.com, jthoughton@google.com, corbet@lwn.net,
        dave.hansen@intel.com, kirill@shutemov.name, luto@kernel.org,
        brauner@kernel.org, arnd@arndb.de, ebiederm@xmission.com,
        catalin.marinas@arm.com, mingo@redhat.com, peterz@infradead.org,
        liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
        jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        muchun.song@linux.dev, tglx@linutronix.de, cgroups@vger.kernel.org,
        x86@kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhiramat@kernel.org,
        rostedt@goodmis.org, vasily.averin@linux.dev, xhao@linux.alibaba.com,
        pcc@google.com, neilb@suse.de, maz@kernel.org
Subject: [PATCH 00/20] Add support for shared PTEs across processes
Date: Fri, 24 Jan 2025 15:54:34 -0800
Message-ID: <20250124235454.84587-1-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_10,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=918 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501240162
X-Proofpoint-ORIG-GUID: wA1C3sCgmGoajTKXBQCcnh_dXJ_okO_B
X-Proofpoint-GUID: wA1C3sCgmGoajTKXBQCcnh_dXJ_okO_B

Memory pages shared between processes require page table entries
(PTEs) for each process. Each of these PTEs consume some of
the memory and as long as the number of mappings being maintained
is small enough, this space consumed by page tables is not
objectionable. When very few memory pages are shared between
processes, the number of PTEs to maintain is mostly constrained by
the number of pages of memory on the system. As the number of shared
pages and the number of times pages are shared goes up, amount of
memory consumed by page tables starts to become significant. This
issue does not apply to threads. Any number of threads can share the
same pages inside a process while sharing the same PTEs. Extending
this same model to sharing pages across processes can eliminate this
issue for sharing across processes as well.

Some of the field deployments commonly see memory pages shared
across 1000s of processes. On x86_64, each page requires a PTE that
is 8 bytes long which is very small compared to the 4K page
size. When 2000 processes map the same page in their address space,
each one of them requires 8 bytes for its PTE and together that adds
up to 8K of memory just to hold the PTEs for one 4K page. On a
database server with 300GB SGA, a system crash was seen with
out-of-memory condition when 1500+ clients tried to share this SGA
even though the system had 512GB of memory. On this server, in the
worst case scenario of all 1500 processes mapping every page from
SGA would have required 878GB+ for just the PTEs. If these PTEs
could be shared, the a substantial amount of memory saved.

This patch series implements a mechanism that allows userspace
processes to opt into sharing PTEs. It adds a new in-memory
filesystem - msharefs. A file created on msharefs represents a
shared region where all processes mapping that region will map
objects within it with shared PTEs. When the file is created,
a new host mm struct is created to hold the shared page tables
and vmas for objects later mapped into the shared region. This
host mm struct is associated with the file and not with a task.
When a process mmap's the shared region, a vm flag VM_MSHARE
is added to the vma. On page fault the vma is checked for the
presence of the VM_MSHARE flag. If found, the host mm is
searched for a vma that covers the fault address. Fault handling
then continues using that host vma which establishes PTEs in the
host mm. Fault handling in a shared region also links the shared
page table to the process page table if the shared page table
already exists.

Ioctls are used to set/get the start address and size of the host
mm, to map objects into the shared region, and to (eventually)
perform other operations on the shared objects such as changing
protections.

API
===

mshare does not introduce a new API. It instead uses existing APIs
to implement page table sharing. The steps to use this feature are:

1. Mount msharefs on /sys/fs/mshare -
        mount -t msharefs msharefs /sys/fs/mshare

2. mshare regions have alignment and size requirements. Start
   address for the region must be aligned to an address boundary and
   be a multiple of fixed size. This alignment and size requirement
   can be obtained by reading the file /sys/fs/mshare/mshare_info
   which returns a number in text format. mshare regions must be
   aligned to this boundary and be a multiple of this size.

3. For the process creating an mshare region:
        a. Create a file on /sys/fs/mshare, for example -
                fd = open("/sys/fs/mshare/shareme",
                                O_RDWR|O_CREAT|O_EXCL, 0600);

        b. Establish the starting address and size of the region
                struct mshare_info minfo;

                minfo.start = TB(2);
                minfo.size = BUFFER_SIZE;
                ioctl(fd, MSHAREFS_SET_SIZE, &minfo)

        c. Map some memory in the region
                struct mshare_create mcreate;

                mcreate.addr = TB(2);
                mcreate.size = BUFFER_SIZE;
                mcreate.offset = 0;
                mcreate.prot = PROT_READ | PROT_WRITE;
                mcreate.flags = MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED;
                mcreate.fd = -1;

                ioctl(fd, MSHAREFS_CREATE_MAPPING, &mcreate)

        d. Map the mshare region into the process
                mmap((void *)TB(2), BUF_SIZE, PROT_READ | PROT_WRITE,
                        MAP_SHARED, fd, 0);

        e. Write and read to mshared region normally.

4. For processes attaching an mshare region:
        a. Open the file on msharefs, for example -
                fd = open("/sys/fs/mshare/shareme", O_RDWR);

        b. Get information about mshare'd region from the file:
                struct mshare_info minfo;

                ioctl(fd, MSHAREFS_GET_SIZE, &minfo);

        c. Map the mshare'd region into the process
                mmap(minfo.start, minfo.size,
                        PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);

5. To delete the mshare region -
                unlink("/sys/fs/mshare/shareme");



Example Code
============

Snippet of the code that a donor process would run looks like below:

-----------------
        struct mshare_info minfo;
        struct mshare_create mcreate;

        fd = open("/sys/fs/mshare/mshare_info", O_RDONLY);
        read(fd, req, 128);
        alignsize = atoi(req);
        close(fd);
        fd = open("/sys/fs/mshare/shareme", O_RDWR|O_CREAT|O_EXCL, 0600);
        start = alignsize * 4;
        size = alignsize * 2;

        minfo.start = start;
        minfo.size = size;
        ret = ioctl(fd, MSHAREFS_SET_SIZE, &minfo);
        if (ret < 0)
                perror("ERROR: MSHAREFS_SET_SIZE");

        mcreate.addr = start;
        mcreate.size = size;
        mcreate.offset = 0;
        mcreate.prot = PROT_READ | PROT_WRITE;
        mcreate.flags = MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED;
        mcreate.fd = -1;
        ret = ioctl(fd, MSHAREFS_CREATE_MAPPING, &mcreate);
        if (ret < 0)
                perror("ERROR: MSHAREFS_CREATE_MAPPING");

        addr = mmap((void *)start, size, PROT_READ | PROT_WRITE,
                        MAP_SHARED, fd, 0);
        if (addr == MAP_FAILED)
                perror("ERROR: mmap failed");

        strncpy(addr, "Some random shared text",
                        sizeof("Some random shared text"));
-----------------

Snippet of code that a consumer process would execute looks like:

-----------------
        struct mshare_info minfo;

        fd = open("/sys/fs/mshare/shareme", O_RDONLY);

        ret = ioctl(fd, MSHAREFS_GET_SIZE, &minfo);
        if (ret < 0)
                perror("ERROR: MSHAREFS_GET_SIZE");
        if (!minfo.start)
                perror("ERROR: mshare region not init'd");

        addr = mmap(minfo.start, minfo.size, PROT_READ | PROT_WRITE,
                        MAP_SHARED, fd, 0);

        printf("Guest mmap at %px:\n", addr);
        printf("%s\n", addr);
        printf("\nDone\n");

-----------------

v1:
  - Based on mm-unstable mm-hotfixes-stable-2025-01-16-21-11
  - Use mshare size instead of start address to check if mshare region
    has been initialized.
  - Share page tables at PUD level instead of PGD.
  - Rename vma_is_shared() to vma_is_mshare() (James H / David H)
  - Introduce and use mmap_read_lock_nested() (Kirill)
  - Use an mmu notifier to flush all TLBs when updating shared pagetable
    mappings. (Dave Hansen)
  - Move logic for finding the shared vma to use to handle a fault from
    handle_mm_fault() to do_user_addr_fault() because the arch-specific
    fault handling checks vma flags for access permissions.
  - Add CONFIG_MSHARE / ARCH_SUPPORTS_MSHARE 
  - Add msharefs_get_unmapped_area()
  - Implemented vm_ops->unmap_page_range (Kirill)
  - Update free_pgtables/free_pgd_range to free process pagetable levels
    but not shared pagetable levels.
  - A first take at cgroup support

RFC v2 -> v3:
  - Now based on 6.11-rc5
  - Addressed many comments from v2.
  - Simplified filesystem code. Removed refcounting of the
    shared mm_struct allocated for an mshare file. The mm_struct
    and the pagetables and mappings it contains are freed when
    the inode is evicted.
  - Switched to an ioctl-based interface. Ioctls implemented
    are used to set and get the start address and size of an
    mshare region and to map objects into an mshare region
    (only anon shared memory is supported in this series).
  - Updated example code

[1] v2: https://lore.kernel.org/linux-mm/cover.1656531090.git.khalid.aziz@oracle.com/


RFC v1 -> v2:
  - Eliminated mshare and mshare_unlink system calls and
    replaced API with standard mmap and unlink (Based upon
    v1 patch discussions and LSF/MM discussions)
  - All fd based API (based upon feedback and suggestions from
    Andy Lutomirski, Eric Biederman, Kirill and others)
  - Added a file /sys/fs/mshare/mshare_info to provide
    alignment and size requirement info (based upon feedback
    from Dave Hansen, Mark Hemment and discussions at LSF/MM)
  - Addressed TODOs in v1
  - Added support for directories in msharefs
  - Added locks around any time vma is touched (Dave Hansen)
  - Eliminated the need to point vm_mm in original vmas to the
    newly synthesized mshare mm
  - Ensured mmap_read_unlock is called for correct mm in
    handle_mm_fault (Dave Hansen)


Anthony Yznaga (13):
  mm/mshare: allocate an mm_struct for msharefs files
  mm/mshare: flush all TLBs when updating PTEs in an mshare range
  sched/numa: do not scan msharefs vmas
  mm: add mmap_read_lock_killable_nested()
  mm: add and use unmap_page_range vm_ops hook
  x86/mm: enable page table sharing
  mm: create __do_mmap() to take an mm_struct * arg
  mm: pass the mm in vma_munmap_struct
  mshare: add MSHAREFS_CREATE_MAPPING
  mshare: add MSHAREFS_UNMAP
  mm/mshare: provide a way to identify an mm as an mshare host mm
  mm/mshare: get memcg from current->mm instead of mshare mm
  mm/mshare: associate a mem cgroup with an mshare file

Khalid Aziz (7):
  mm: Add msharefs filesystem
  mm/mshare: pre-populate msharefs with information file
  mm/mshare: make msharefs writable and support directories
  mm/mshare: Add ioctl support
  mm/mshare: Add a vma flag to indicate an mshare region
  mm/mshare: Add mmap support
  mm/mshare: prepare for page table sharing support

 Documentation/filesystems/msharefs.rst        | 107 +++
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 arch/Kconfig                                  |   3 +
 arch/x86/Kconfig                              |   1 +
 arch/x86/mm/fault.c                           |  48 +-
 include/linux/memcontrol.h                    |   3 +
 include/linux/mm.h                            |  56 ++
 include/linux/mm_types.h                      |   2 +
 include/linux/mmap_lock.h                     |   7 +
 include/trace/events/mmflags.h                |   7 +
 include/uapi/linux/magic.h                    |   1 +
 include/uapi/linux/msharefs.h                 |  45 ++
 ipc/shm.c                                     |  17 +
 kernel/sched/fair.c                           |   3 +-
 mm/Kconfig                                    |   9 +
 mm/Makefile                                   |   4 +
 mm/hugetlb.c                                  |  25 +
 mm/memcontrol.c                               |   3 +-
 mm/memory.c                                   |  74 +-
 mm/mmap.c                                     |   7 +-
 mm/mshare.c                                   | 708 ++++++++++++++++++
 mm/vma.c                                      |  25 +-
 mm/vma.h                                      |   3 +-
 23 files changed, 1108 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/filesystems/msharefs.rst
 create mode 100644 include/uapi/linux/msharefs.h
 create mode 100644 mm/mshare.c

-- 
2.43.5


