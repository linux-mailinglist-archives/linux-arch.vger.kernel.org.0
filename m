Return-Path: <linux-arch+bounces-13215-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC864B2D122
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 03:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98BF65A02E8
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 01:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CA52153F1;
	Wed, 20 Aug 2025 01:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d+OVceRi"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4641F1537;
	Wed, 20 Aug 2025 01:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755651961; cv=none; b=lHb0W7irEuOPi/xWzixe5w5zPOqmUdBCcZdHORhAOm75zMCHK/al8ojcA8Nuip4kyGEy9k469Mdgf1iZZIvO8L5vNkO5ZrK0A83NNFMZ2IdgSYhW3k/WMFc7fr8owyTdw4GhPFyyYYJDq7iMufTSJDZz8IAugsYotCrzhEraUZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755651961; c=relaxed/simple;
	bh=BP0s0ZRJzzvDjOYC+uOZKUUt2q2jXkrQCyiVPtaMOTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pvlPJ8qUSN3LBnPqnnfo2Y0BulZCQnEuQ31wnxojczAou9EqT7rkbzrNMGmMEtjzEzRMH62hfwLfFHKla98oygob5QiiDslf6T6ktdkSY0ojkA+8escgwDtuy23cr6d/hkEUaf7Vk2V6ikqGlL11G+s/NFqWtV+MTwtf0hH7wn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d+OVceRi; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JLCuZS018276;
	Wed, 20 Aug 2025 01:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=yOxEwT+T1uqOenKkiLLGcZTLlycG8
	JzdJvAh7LNRZAo=; b=d+OVceRi8FoTPSnr+nZurx+xT0P5n2i3EBibLN9opc5Nz
	PDD7EEvHzXoOI/HUgqfP8VRGasRtQiY+LqS4+tDxlw/jvUsH4uN+TOtvvpy89ZYA
	vdaXzSQl2DUvXRBDqy1xdZHl+TlGIeykt3ZXlqWIHQ4o5hg1t411w+/i9olWAfac
	VyXtBw5RyTk17aeHpDnXCFxL+LF3rl1qB4Ky1QOPh7xPZ7HUD1Kx7EkO4NXZSXW8
	CH4dUQKPe+R4eP7OG8wPt1tCxCJBdXI1PxxZR1NYVAlFOa1Mxm26HPPca+LjwgMZ
	ABjqfjJkzCKb/LEEMVKHZR34mc6U2Cpabo65iYpuQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0ttg8bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 01:04:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57JNbsob007234;
	Wed, 20 Aug 2025 01:04:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3q29m6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 01:04:24 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57K14Nd4011685;
	Wed, 20 Aug 2025 01:04:23 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48my3q29gw-1;
	Wed, 20 Aug 2025 01:04:23 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org, andreyknvl@gmail.com, arnd@arndb.de,
        bp@alien8.de, brauner@kernel.org, bsegall@google.com, corbet@lwn.net,
        dave.hansen@linux.intel.com, david@redhat.com,
        dietmar.eggemann@arm.com, ebiederm@xmission.com, hpa@zytor.com,
        jakub.wartak@mailbox.org, jannh@google.com, juri.lelli@redhat.com,
        khalid@kernel.org, liam.howlett@oracle.com, linyongting@bytedance.com,
        lorenzo.stoakes@oracle.com, luto@kernel.org, markhemm@googlemail.com,
        maz@kernel.org, mhiramat@kernel.org, mgorman@suse.de, mhocko@suse.com,
        mingo@redhat.com, muchun.song@linux.dev, neilb@suse.de,
        osalvador@suse.de, pcc@google.com, peterz@infradead.org,
        pfalcato@suse.de, rostedt@goodmis.org, rppt@kernel.org,
        shakeel.butt@linux.dev, surenb@google.com, tglx@linutronix.de,
        vasily.averin@linux.dev, vbabka@suse.cz, vincent.guittot@linaro.org,
        viro@zeniv.linux.org.uk, vschneid@redhat.com, willy@infradead.org,
        x86@kernel.org, xhao@linux.alibaba.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v3 00/22] Add support for shared PTEs across processes
Date: Tue, 19 Aug 2025 18:03:53 -0700
Message-ID: <20250820010415.699353-1-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508200007
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX+SEU8RDqteOz
 XUMpaVaMowy1Tb6w4TIC5QCSee2MKsZ0fkxpxNj4ZSSJL3dZTdOEbW4H9XnR5H8tXRttDHaC3O/
 99gbLxvusWcbJv3R8Nap1CR7bVt6hxVEmxwHCP/ZHLMS9FMRh/VQzcPVYg85Oxnm4Hr48z9inLs
 5xsD3c5+VEhEcNtHivpn9iyx6Ydi+BS5JMecHCAeAWJYIx+VvmtQHTe0D5MeXXwdXMvs4rk/rTH
 dQ9pDsUMRluHA5/5ljIymUKg6ktUIXtYJVo0abr5XydoAAz/2a/jUmjWEbz2q84zCbW1TMZ/S0X
 VYoUVyY5oLPcL3ZCLbutpuO4PgBjKiQNvK0070Hu0HrvFnovQmQfad88GsY64tVpurjw2zNkUYx
 7ZweZavRfXuN4x8Y8gRvnaxw0mSBjw==
X-Proofpoint-GUID: zMqsmGIGkx_DvU6VbeGf39ZlkMNr0VZB
X-Proofpoint-ORIG-GUID: zMqsmGIGkx_DvU6VbeGf39ZlkMNr0VZB
X-Authority-Analysis: v=2.4 cv=V94kEeni c=1 sm=1 tr=0 ts=68a51f19 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=zf8HbCBmOu6KmpLAX5MA:9
 a=3tvOSNxEL8ccU_JU:21 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=QOGEsqRv6VhmHaoFNykA:22

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

Ioctls are used to map and unmap objects in the shared region and
to (eventually) perform other operations on the shared objects such
as changing protections.

API
===

The steps to use this feature are:

1. Mount msharefs on /sys/fs/mshare -
        mount -t msharefs msharefs /sys/fs/mshare

2. mshare regions have alignment and size requirements. The start
   address for the region must be aligned to an address boundary and
   be a multiple of fixed size. This alignment and size requirement
   can be obtained by reading the file /sys/fs/mshare/mshare_info
   which returns a number in text format. mshare regions must be
   aligned to this boundary and be a multiple of this size.

3. For the process creating an mshare region:
        a. Create a file on /sys/fs/mshare, for example -
                fd = open("/sys/fs/mshare/shareme",
                                O_RDWR|O_CREAT|O_EXCL, 0600);

        b. Establish the size of the region
                ftruncate(fd, BUFFER_SIZE);

        c. Map some memory in the region
                struct mshare_create mcreate;

                mcreate.region_offset = 0;
                mcreate.size = BUFFER_SIZE;
                mcreate.offset = 0;
                mcreate.prot = PROT_READ | PROT_WRITE;
                mcreate.flags = MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED;
                mcreate.fd = -1;

                ioctl(fd, MSHAREFS_CREATE_MAPPING, &mcreate)

        d. Map the mshare region into the process
                mmap((void *)TB(2), BUFFER_SIZE, PROT_READ | PROT_WRITE,
                        MAP_FIXED | MAP_SHARED, fd, 0);

        e. Write and read to mshared region normally.

4. For processes attaching an mshare region:
        a. Open the file on msharefs, for example -
                fd = open("/sys/fs/mshare/shareme", O_RDWR);

        b. Get information about mshare'd region from the file:
                struct stat sb;

                fstat(fd, &sb);
                mshare_size = sb.st_size;

        c. Map the mshare'd region into the process
                mmap((void *)TB(2), mshare_size, PROT_READ | PROT_WRITE,
                        MAP_FIXED | MAP_SHARED, fd, 0);

5. To delete the mshare region -
                unlink("/sys/fs/mshare/shareme");



Example Code
============

Snippet of the code that a donor process would run looks like below:

-----------------
        struct mshare_create mcreate;

        fd = open("/sys/fs/mshare/mshare_info", O_RDONLY);
        read(fd, req, 128);
        alignsize = atoi(req);
        close(fd);
        fd = open("/sys/fs/mshare/shareme", O_RDWR|O_CREAT|O_EXCL, 0600);
        start = alignsize * 4;
        size = alignsize * 2;

        ftruncate(fd, size);

        mcreate.region_offset = 0;
        mcreate.size = size;
        mcreate.offset = 0;
        mcreate.prot = PROT_READ | PROT_WRITE;
        mcreate.flags = MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED;
        mcreate.fd = -1;
        ret = ioctl(fd, MSHAREFS_CREATE_MAPPING, &mcreate);
        if (ret < 0)
                perror("ERROR: MSHAREFS_CREATE_MAPPING");

        addr = mmap((void *)start, size, PROT_READ | PROT_WRITE,
                        MAP_FIXED | MAP_SHARED, fd, 0);
        if (addr == MAP_FAILED)
                perror("ERROR: mmap failed");

        strncpy(addr, "Some random shared text",
                        sizeof("Some random shared text"));
-----------------

Snippet of code that a consumer process would execute looks like:

-----------------
        fd = open("/sys/fs/mshare/shareme", O_RDONLY);

        fstat(fd, &sb);
        size = sb.st_size;

        if (!size)
                perror("ERROR: mshare region not init'd");

        addr = mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);

        printf("Guest mmap at %px:\n", addr);
        printf("%s\n", addr);
        printf("\nDone\n");

-----------------

v3:
  - Based on mm-new as of 2025-08-15
  - (Fix) When unmapping an msharefs VMA, unlink the shared page tables
    from the process page table using the new unmap_page_range vm_ops hook
    rather than having free_pgtables() skip mshare VMAs (Jann Horn).
  - (Fix) Keep a reference count on shared PUD pages to prevent UAF when
    the unmap of objects in the mshare region also frees shared page
    tables.
  - (New) Support mapping files and anonymous hugetlb memory in an mshare
    region.
  - (New) Implement ownership of mshare regions. The process that
    creates an mshare region is assigned as the owner. See the patch for
    details.
  - (Changed) Undid previous attempt at cgroup support. Cgroup accounting
    is now directed to the owner process.
  - (TBD) Support for mmu notifiers is not yet implemented. There are some
    hurdles to be overcome. Mentioned here because it came up in comments
    on the v2 series (Jann Horn).

v2:
  (https://lore.kernel.org/all/20250404021902.48863-1-anthony.yznaga@oracle.com/)
  - Based on mm-unstable as of 2025-04-03 (8ff02705ba8f)
  - Set mshare size via fallocate or ftruncate instead of MSHAREFS_SET_SIZE.
    Removed MSHAREFS_SET_SIZE/MSHAREFS_GET_SIZE ioctls. Use stat to get size.
    (David H)
  - Remove spinlock from mshare_data. Initializing the size is protected by
    the inode lock.
  - Support mapping a single mshare region at different virtual addresses.
  - Support system selection of the start address when mmap'ing an mshare
    region.
  - Changed MSHAREFS_CREATE_MAPPING and MSHAREFS_UNMAP to use a byte offset
    to specify the start of a mapping.
  - Updated documentation.

v1:
  (https://lore.kernel.org/linux-mm/20250124235454.84587-1-anthony.yznaga@oracle.com/)
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

Anthony Yznaga (15):
  mm/mshare: allocate an mm_struct for msharefs files
  mm/mshare: add ways to set the size of an mshare region
  mm/mshare: flush all TLBs when updating PTEs in an mshare range
  sched/numa: do not scan msharefs vmas
  mm: add mmap_read_lock_killable_nested()
  mm: add and use unmap_page_range vm_ops hook
  mm: introduce PUD page table shared count
  x86/mm: enable page table sharing
  mm: create __do_mmap() to take an mm_struct * arg
  mm: pass the mm in vma_munmap_struct
  sched/mshare: mshare ownership
  mm/mshare: Add an ioctl for unmapping objects in an mshare region
  mm/mshare: support mapping files and anon hugetlb in an mshare region
  mm/mshare: provide a way to identify an mm as an mshare host mm
  mm/mshare: charge fault handling allocations to the mshare owner

Khalid Aziz (7):
  mm: Add msharefs filesystem
  mm/mshare: pre-populate msharefs with information file
  mm/mshare: make msharefs writable and support directories
  mm/mshare: Add a vma flag to indicate an mshare region
  mm/mshare: Add mmap support
  mm/mshare: prepare for page table sharing support
  mm/mshare: Add an ioctl for mapping objects in an mshare region

 Documentation/filesystems/index.rst           |   1 +
 Documentation/filesystems/msharefs.rst        |  96 ++
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 arch/Kconfig                                  |   3 +
 arch/x86/Kconfig                              |   1 +
 arch/x86/mm/fault.c                           |  40 +-
 include/linux/mm.h                            |  52 +
 include/linux/mm_types.h                      |  38 +-
 include/linux/mmap_lock.h                     |   7 +
 include/linux/mshare.h                        |  25 +
 include/linux/sched.h                         |   5 +
 include/trace/events/mmflags.h                |   7 +
 include/uapi/linux/magic.h                    |   1 +
 include/uapi/linux/msharefs.h                 |  38 +
 ipc/shm.c                                     |  17 +
 kernel/exit.c                                 |   1 +
 kernel/fork.c                                 |   1 +
 kernel/sched/fair.c                           |   3 +-
 mm/Kconfig                                    |  11 +
 mm/Makefile                                   |   4 +
 mm/hugetlb.c                                  |  25 +
 mm/memory.c                                   |  76 +-
 mm/mmap.c                                     |  10 +-
 mm/mshare.c                                   | 942 ++++++++++++++++++
 mm/vma.c                                      |  22 +-
 mm/vma.h                                      |   3 +-
 26 files changed, 1385 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/filesystems/msharefs.rst
 create mode 100644 include/linux/mshare.h
 create mode 100644 include/uapi/linux/msharefs.h
 create mode 100644 mm/mshare.c

-- 
2.47.1


