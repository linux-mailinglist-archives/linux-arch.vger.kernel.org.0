Return-Path: <linux-arch+bounces-2521-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF2085C5E6
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 21:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7BCB2824D6
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 20:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACA0151CCA;
	Tue, 20 Feb 2024 20:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="UXr8sKPP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D2B150991;
	Tue, 20 Feb 2024 20:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708461228; cv=none; b=IxjFE6HTxbrwEI96nZ50diJHp5rw/i8MQc9Vk9Dh/EoP1hRR/lMxNOUCBSSnYtfJ/V0/AwprtjqPbxMXETQUyratN4rP1ILXeMKRoxLNkSwjEPhPWXkfR6B74N5YHX6JLDEIHWsmpN5JvxFyRkjSxrtmEHHaQ/kEWkiMm527bJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708461228; c=relaxed/simple;
	bh=kIHH0cooVYActrYEV0TilEGQ5DXxtwVkOOPB79ofTVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=LMbQ/IMUp7RATpn9AMKkPj8eTDrWzo/tNIOTg9v8ZGMUCsvsR8Yac9u9LUkGcUbywK78dxDBntWCRtFS0OBVsb2+wZDEzImYgONfKL4opgOMxG3tY2u5QfPG8i/J2wKHlTXJ2uSufhH8YRgnXn1mKgUdocF1hHpds31Xm0NdJs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=UXr8sKPP; arc=none smtp.client-ip=148.163.152.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355090.ppops.net [127.0.0.1])
	by m0355090.ppops.net (8.17.1.24/8.17.1.24) with ESMTP id 41KJFO83021030;
	Tue, 20 Feb 2024 20:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	DKIM202306; bh=73sw9qCcfHZDBF19mVjUh6QeXe6a4xhn7+e2L7eQ6wM=; b=U
	Xr8sKPPpKTWY8rQgN86shbmM6QDZi7UtwRsqBighe6FWxZoOMr6rIACyHTESh75p
	TaL+95m5h12hLM5fp+Euf/jpR5gd7C73csAZN+uMDLfdBEHVEr+v2bWSF8o3aZfD
	wE1FP/JHojDSvWjg+Weok6tYyOEFZmPfFjwLuT0/cfby0Z8Cp3JSKGDPy/4Q+SbF
	unNaBT16quJy/oUQBcJEr8wXJnMUJ0mpzHNACQneQBUbNzjyNngstVLKsGYt6i/N
	jwgsKjxGh6oxHNJAUG/i0kOAAiZwKG1/4JWNGXVIoW+REj0gJzWZglScJ2Z4kwi0
	BsyzVxBJqxVLlH4hfPsqA==
Received: from va32lpfpp01.lenovo.com ([104.232.228.21])
	by m0355090.ppops.net (PPS) with ESMTPS id 3wd231g7tc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 20:33:18 +0000 (GMT)
Received: from ilclmmrp01.lenovo.com (ilclmmrp01.mot.com [100.65.83.165])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by va32lpfpp01.lenovo.com (Postfix) with ESMTPS id 4TfWM15BdpzldQn;
	Tue, 20 Feb 2024 20:33:17 +0000 (UTC)
Received: from ilclasset01.mot.com (ilclasset01.mot.com [100.64.7.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by ilclmmrp01.lenovo.com (Postfix) with ESMTPSA id 4TfWM13X59z3n3fr;
	Tue, 20 Feb 2024 20:33:17 +0000 (UTC)
From: Maxwell Bland <mbland@motorola.com>
To: linux-arm-kernel@lists.infradead.org
Cc: gregkh@linuxfoundation.org, agordeev@linux.ibm.com,
        akpm@linux-foundation.org, andreyknvl@gmail.com, andrii@kernel.org,
        aneesh.kumar@kernel.org, aou@eecs.berkeley.edu, ardb@kernel.org,
        arnd@arndb.de, ast@kernel.org, borntraeger@linux.ibm.com,
        bpf@vger.kernel.org, brauner@kernel.org, catalin.marinas@arm.com,
        christophe.leroy@csgroup.eu, cl@linux.com, daniel@iogearbox.net,
        dave.hansen@linux.intel.com, david@redhat.com, dennis@kernel.org,
        dvyukov@google.com, glider@google.com, gor@linux.ibm.com,
        guoren@kernel.org, haoluo@google.com, hca@linux.ibm.com,
        hch@infradead.org, john.fastabend@gmail.com, jolsa@kernel.org,
        kasan-dev@googlegroups.com, kpsingh@kernel.org,
        linux-arch@vger.kernel.org, linux@armlinux.org.uk,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        lstoakes@gmail.com, mark.rutland@arm.com, martin.lau@linux.dev,
        meted@linux.ibm.com, michael.christie@oracle.com, mjguzik@gmail.com,
        mpe@ellerman.id.au, mst@redhat.com, muchun.song@linux.dev,
        naveen.n.rao@linux.ibm.com, npiggin@gmail.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, quic_nprakash@quicinc.com,
        quic_pkondeti@quicinc.com, rick.p.edgecombe@intel.com,
        ryabinin.a.a@gmail.com, ryan.roberts@arm.com, samitolvanen@google.com,
        sdf@google.com, song@kernel.org, surenb@google.com,
        svens@linux.ibm.com, tj@kernel.org, urezki@gmail.com,
        vincenzo.frascino@arm.com, will@kernel.org, wuqiang.matt@bytedance.com,
        yonghong.song@linux.dev, zlim.lnx@gmail.com, mbland@motorola.com,
        awheeler@motorola.com
Subject: [PATCH 1/4] mm/vmalloc: allow arch-specific vmalloc_node overrides
Date: Tue, 20 Feb 2024 14:32:53 -0600
Message-Id: <20240220203256.31153-2-mbland@motorola.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240220203256.31153-1-mbland@motorola.com>
References: <20240220203256.31153-1-mbland@motorola.com>
X-Proofpoint-GUID: wzagho37jhijkGrV1Lgjn4DCAKqFMTDO
X-Proofpoint-ORIG-GUID: wzagho37jhijkGrV1Lgjn4DCAKqFMTDO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402200146
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Present non-uniform use of __vmalloc_node and __vmalloc_node_range makes
enforcing appropriate code and data seperation untenable on certain
microarchitectures, as VMALLOC_START and VMALLOC_END are monolithic
while the use of the vmalloc interface is non-monolithic: in particular,
appropriate randomness in ASLR makes it such that code regions must fall
in some region between VMALLOC_START and VMALLOC_end, but this
necessitates that code pages are intermingled with data pages, meaning
code-specific protections, such as arm64's PXNTable, cannot be
performantly runtime enforced.

The solution to this problem allows architectures to override the
vmalloc wrapper functions by enforcing that the rest of the kernel does
not reimplement __vmalloc_node by using __vmalloc_node_range with the
same parameters as __vmalloc_node or provides a __weak tag to those
functions using __vmalloc_node_range with parameters repeating those of
__vmalloc_node.

Two benefits of this approach are (1) greater flexibility to each
architecture for handling of virtual memory while not compromising the
kernel's vmalloc logic and (2) more uniform use of the __vmalloc_node
interface, reserving the more specialized __vmalloc_node_range for more
specialized cases, such as kasan's shadow memory.

Signed-off-by: Maxwell Bland <mbland@motorola.com>
---
 arch/arm/kernel/irq.c               |  2 +-
 arch/arm64/include/asm/vmap_stack.h |  2 +-
 arch/arm64/kernel/efi.c             |  2 +-
 arch/powerpc/kernel/irq.c           |  2 +-
 arch/riscv/include/asm/irq_stack.h  |  2 +-
 arch/s390/hypfs/hypfs_diag.c        |  2 +-
 arch/s390/kernel/setup.c            |  6 ++---
 arch/s390/kernel/sthyi.c            |  2 +-
 include/linux/vmalloc.h             | 15 ++++++++++-
 kernel/bpf/syscall.c                |  4 +--
 kernel/fork.c                       |  4 +--
 kernel/scs.c                        |  3 +--
 lib/objpool.c                       |  2 +-
 lib/test_vmalloc.c                  |  6 ++---
 mm/util.c                           |  3 +--
 mm/vmalloc.c                        | 39 +++++++++++------------------
 16 files changed, 47 insertions(+), 49 deletions(-)

diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index fe28fc1f759d..109f4f363621 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -61,7 +61,7 @@ static void __init init_irq_stacks(void)
 						       THREAD_SIZE_ORDER);
 		else
 			stack = __vmalloc_node(THREAD_SIZE, THREAD_ALIGN,
-					       THREADINFO_GFP, NUMA_NO_NODE,
+					       THREADINFO_GFP, 0, NUMA_NO_NODE,
 					       __builtin_return_address(0));
 
 		if (WARN_ON(!stack))
diff --git a/arch/arm64/include/asm/vmap_stack.h b/arch/arm64/include/asm/vmap_stack.h
index 20873099c035..57a7eaa720d5 100644
--- a/arch/arm64/include/asm/vmap_stack.h
+++ b/arch/arm64/include/asm/vmap_stack.h
@@ -21,7 +21,7 @@ static inline unsigned long *arch_alloc_vmap_stack(size_t stack_size, int node)
 
 	BUILD_BUG_ON(!IS_ENABLED(CONFIG_VMAP_STACK));
 
-	p = __vmalloc_node(stack_size, THREAD_ALIGN, THREADINFO_GFP, node,
+	p = __vmalloc_node(stack_size, THREAD_ALIGN, THREADINFO_GFP, 0, node,
 			__builtin_return_address(0));
 	return kasan_reset_tag(p);
 }
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 0228001347be..48efa31a9161 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -205,7 +205,7 @@ static int __init arm64_efi_rt_init(void)
 		return 0;
 
 	p = __vmalloc_node(THREAD_SIZE, THREAD_ALIGN, GFP_KERNEL,
-			   NUMA_NO_NODE, &&l);
+			   0, NUMA_NO_NODE, &&l);
 l:	if (!p) {
 		pr_warn("Failed to allocate EFI runtime stack\n");
 		clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 6f7d4edaa0bc..ceb7ea07ca28 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -308,7 +308,7 @@ DEFINE_INTERRUPT_HANDLER_ASYNC(do_IRQ)
 static void *__init alloc_vm_stack(void)
 {
 	return __vmalloc_node(THREAD_SIZE, THREAD_ALIGN, THREADINFO_GFP,
-			      NUMA_NO_NODE, (void *)_RET_IP_);
+			      0, NUMA_NO_NODE, (void *)_RET_IP_);
 }
 
 static void __init vmap_irqstack_init(void)
diff --git a/arch/riscv/include/asm/irq_stack.h b/arch/riscv/include/asm/irq_stack.h
index 6441ded3b0cf..d2410735bde0 100644
--- a/arch/riscv/include/asm/irq_stack.h
+++ b/arch/riscv/include/asm/irq_stack.h
@@ -24,7 +24,7 @@ static inline unsigned long *arch_alloc_vmap_stack(size_t stack_size, int node)
 {
 	void *p;
 
-	p = __vmalloc_node(stack_size, THREAD_ALIGN, THREADINFO_GFP, node,
+	p = __vmalloc_node(stack_size, THREAD_ALIGN, THREADINFO_GFP, 0, node,
 			__builtin_return_address(0));
 	return kasan_reset_tag(p);
 }
diff --git a/arch/s390/hypfs/hypfs_diag.c b/arch/s390/hypfs/hypfs_diag.c
index 279b7bba4d43..16359d854288 100644
--- a/arch/s390/hypfs/hypfs_diag.c
+++ b/arch/s390/hypfs/hypfs_diag.c
@@ -70,7 +70,7 @@ void *diag204_get_buffer(enum diag204_format fmt, int *pages)
 			return ERR_PTR(-EOPNOTSUPP);
 	}
 	diag204_buf = __vmalloc_node(array_size(*pages, PAGE_SIZE),
-				     PAGE_SIZE, GFP_KERNEL, NUMA_NO_NODE,
+				     PAGE_SIZE, GFP_KERNEL, 0, NUMA_NO_NODE,
 				     __builtin_return_address(0));
 	if (!diag204_buf)
 		return ERR_PTR(-ENOMEM);
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index d1f3b56e7afc..2c25b4e9f20a 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -254,7 +254,7 @@ static void __init conmode_default(void)
 		cpcmd("QUERY TERM", query_buffer, 1024, NULL);
 		ptr = strstr(query_buffer, "CONMODE");
 		/*
-		 * Set the conmode to 3215 so that the device recognition 
+		 * Set the conmode to 3215 so that the device recognition
 		 * will set the cu_type of the console to 3215. If the
 		 * conmode is 3270 and we don't set it back then both
 		 * 3215 and the 3270 driver will try to access the console
@@ -314,7 +314,7 @@ static inline void setup_zfcpdump(void) {}
 
  /*
  * Reboot, halt and power_off stubs. They just call _machine_restart,
- * _machine_halt or _machine_power_off. 
+ * _machine_halt or _machine_power_off.
  */
 
 void machine_restart(char *command)
@@ -364,7 +364,7 @@ unsigned long stack_alloc(void)
 	void *ret;
 
 	ret = __vmalloc_node(THREAD_SIZE, THREAD_SIZE, THREADINFO_GFP,
-			     NUMA_NO_NODE, __builtin_return_address(0));
+			     0, NUMA_NO_NODE, __builtin_return_address(0));
 	kmemleak_not_leak(ret);
 	return (unsigned long)ret;
 #else
diff --git a/arch/s390/kernel/sthyi.c b/arch/s390/kernel/sthyi.c
index 30bb20461db4..5bf239bcdae9 100644
--- a/arch/s390/kernel/sthyi.c
+++ b/arch/s390/kernel/sthyi.c
@@ -318,7 +318,7 @@ static void fill_diag(struct sthyi_sctns *sctns)
 		return;
 
 	diag204_buf = __vmalloc_node(array_size(pages, PAGE_SIZE),
-				     PAGE_SIZE, GFP_KERNEL, NUMA_NO_NODE,
+				     PAGE_SIZE, GFP_KERNEL, 0, NUMA_NO_NODE,
 				     __builtin_return_address(0));
 	if (!diag204_buf)
 		return;
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index c720be70c8dd..f13bd711ad7d 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -150,7 +150,8 @@ extern void *__vmalloc_node_range(unsigned long size, unsigned long align,
 			pgprot_t prot, unsigned long vm_flags, int node,
 			const void *caller) __alloc_size(1);
 void *__vmalloc_node(unsigned long size, unsigned long align, gfp_t gfp_mask,
-		int node, const void *caller) __alloc_size(1);
+		unsigned long vm_flags, int node, const void *caller)
+		__alloc_size(1);
 void *vmalloc_huge(unsigned long size, gfp_t gfp_mask) __alloc_size(1);
 
 extern void *__vmalloc_array(size_t n, size_t size, gfp_t flags) __alloc_size(1, 2);
@@ -295,4 +296,16 @@ bool vmalloc_dump_obj(void *object);
 static inline bool vmalloc_dump_obj(void *object) { return false; }
 #endif
 
+#if defined(CONFIG_64BIT) && defined(CONFIG_ZONE_DMA32)
+#define GFP_VMALLOC32 (GFP_DMA32 | GFP_KERNEL)
+#elif defined(CONFIG_64BIT) && defined(CONFIG_ZONE_DMA)
+#define GFP_VMALLOC32 (GFP_DMA | GFP_KERNEL)
+#else
+/*
+ * 64b systems should always have either DMA or DMA32 zones. For others
+ * GFP_DMA32 should do the right thing and use the normal zone.
+ */
+#define GFP_VMALLOC32 (GFP_DMA32 | GFP_KERNEL)
+#endif
+
 #endif /* _LINUX_VMALLOC_H */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a1f18681721c..79c11307ff40 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -303,8 +303,8 @@ static void *__bpf_map_area_alloc(u64 size, int numa_node, bool mmapable)
 			return area;
 	}
 
-	return __vmalloc_node_range(size, align, VMALLOC_START, VMALLOC_END,
-			gfp | GFP_KERNEL | __GFP_RETRY_MAYFAIL, PAGE_KERNEL,
+	return __vmalloc_node(size, align,
+			gfp | GFP_KERNEL | __GFP_RETRY_MAYFAIL,
 			flags, numa_node, __builtin_return_address(0));
 }
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 0d944e92a43f..800bb1c76000 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -304,10 +304,8 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 	 * so memcg accounting is performed manually on assigning/releasing
 	 * stacks to tasks. Drop __GFP_ACCOUNT.
 	 */
-	stack = __vmalloc_node_range(THREAD_SIZE, THREAD_ALIGN,
-				     VMALLOC_START, VMALLOC_END,
+	stack = __vmalloc_node(THREAD_SIZE, THREAD_ALIGN,
 				     THREADINFO_GFP & ~__GFP_ACCOUNT,
-				     PAGE_KERNEL,
 				     0, node, __builtin_return_address(0));
 	if (!stack)
 		return -ENOMEM;
diff --git a/kernel/scs.c b/kernel/scs.c
index d7809affe740..5b89fb08a392 100644
--- a/kernel/scs.c
+++ b/kernel/scs.c
@@ -43,8 +43,7 @@ static void *__scs_alloc(int node)
 		}
 	}
 
-	s = __vmalloc_node_range(SCS_SIZE, 1, VMALLOC_START, VMALLOC_END,
-				    GFP_SCS, PAGE_KERNEL, 0, node,
+	s = __vmalloc_node(SCS_SIZE, 1, GFP_SCS, 0, node,
 				    __builtin_return_address(0));
 
 out:
diff --git a/lib/objpool.c b/lib/objpool.c
index cfdc02420884..f0acd421a652 100644
--- a/lib/objpool.c
+++ b/lib/objpool.c
@@ -80,7 +80,7 @@ objpool_init_percpu_slots(struct objpool_head *pool, int nr_objs,
 			slot = kmalloc_node(size, pool->gfp, cpu_to_node(i));
 		else
 			slot = __vmalloc_node(size, sizeof(void *), pool->gfp,
-				cpu_to_node(i), __builtin_return_address(0));
+				0, cpu_to_node(i), __builtin_return_address(0));
 		if (!slot)
 			return -ENOMEM;
 		memset(slot, 0, size);
diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
index 3718d9886407..6bde73f892f9 100644
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -97,7 +97,7 @@ static int random_size_align_alloc_test(void)
 		size = ((rnd % 10) + 1) * PAGE_SIZE;
 
 		ptr = __vmalloc_node(size, align, GFP_KERNEL | __GFP_ZERO, 0,
-				__builtin_return_address(0));
+				0, __builtin_return_address(0));
 		if (!ptr)
 			return -1;
 
@@ -120,7 +120,7 @@ static int align_shift_alloc_test(void)
 		align = ((unsigned long) 1) << i;
 
 		ptr = __vmalloc_node(PAGE_SIZE, align, GFP_KERNEL|__GFP_ZERO, 0,
-				__builtin_return_address(0));
+				0, __builtin_return_address(0));
 		if (!ptr)
 			return -1;
 
@@ -138,7 +138,7 @@ static int fix_align_alloc_test(void)
 	for (i = 0; i < test_loop_count; i++) {
 		ptr = __vmalloc_node(5 * PAGE_SIZE, THREAD_ALIGN << 1,
 				GFP_KERNEL | __GFP_ZERO, 0,
-				__builtin_return_address(0));
+				0, __builtin_return_address(0));
 		if (!ptr)
 			return -1;
 
diff --git a/mm/util.c b/mm/util.c
index 5a6a9802583b..c6b7111215e2 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -639,8 +639,7 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
 	 * about the resulting pointer, and cannot play
 	 * protection games.
 	 */
-	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
-			flags, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
+	return __vmalloc_node(size, 1, flags, VM_ALLOW_HUGE_VMAP,
 			node, __builtin_return_address(0));
 }
 EXPORT_SYMBOL(kvmalloc_node);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d12a17fc0c17..18ece28e79d3 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3119,7 +3119,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 
 	/* Please note that the recursion is strictly bounded. */
 	if (array_size > PAGE_SIZE) {
-		area->pages = __vmalloc_node(array_size, 1, nested_gfp, node,
+		area->pages = __vmalloc_node(array_size, 1, nested_gfp, 0, node,
 					area->caller);
 	} else {
 		area->pages = kmalloc_node(array_size, nested_gfp, node);
@@ -3379,11 +3379,12 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
  *
  * Return: pointer to the allocated memory or %NULL on error
  */
-void *__vmalloc_node(unsigned long size, unsigned long align,
-			    gfp_t gfp_mask, int node, const void *caller)
+__weak void *__vmalloc_node(unsigned long size, unsigned long align,
+			    gfp_t gfp_mask, unsigned long vm_flags, int node,
+			    const void *caller)
 {
 	return __vmalloc_node_range(size, align, VMALLOC_START, VMALLOC_END,
-				gfp_mask, PAGE_KERNEL, 0, node, caller);
+				gfp_mask, PAGE_KERNEL, vm_flags, node, caller);
 }
 /*
  * This is only for performance analysis of vmalloc and stress purpose.
@@ -3396,7 +3397,7 @@ EXPORT_SYMBOL_GPL(__vmalloc_node);
 
 void *__vmalloc(unsigned long size, gfp_t gfp_mask)
 {
-	return __vmalloc_node(size, 1, gfp_mask, NUMA_NO_NODE,
+	return __vmalloc_node(size, 1, gfp_mask, 0, NUMA_NO_NODE,
 				__builtin_return_address(0));
 }
 EXPORT_SYMBOL(__vmalloc);
@@ -3415,7 +3416,7 @@ EXPORT_SYMBOL(__vmalloc);
  */
 void *vmalloc(unsigned long size)
 {
-	return __vmalloc_node(size, 1, GFP_KERNEL, NUMA_NO_NODE,
+	return __vmalloc_node(size, 1, GFP_KERNEL, 0, NUMA_NO_NODE,
 				__builtin_return_address(0));
 }
 EXPORT_SYMBOL(vmalloc);
@@ -3432,7 +3433,7 @@ EXPORT_SYMBOL(vmalloc);
  *
  * Return: pointer to the allocated memory or %NULL on error
  */
-void *vmalloc_huge(unsigned long size, gfp_t gfp_mask)
+__weak void *vmalloc_huge(unsigned long size, gfp_t gfp_mask)
 {
 	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
 				    gfp_mask, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
@@ -3455,7 +3456,7 @@ EXPORT_SYMBOL_GPL(vmalloc_huge);
  */
 void *vzalloc(unsigned long size)
 {
-	return __vmalloc_node(size, 1, GFP_KERNEL | __GFP_ZERO, NUMA_NO_NODE,
+	return __vmalloc_node(size, 1, GFP_KERNEL | __GFP_ZERO, 0, NUMA_NO_NODE,
 				__builtin_return_address(0));
 }
 EXPORT_SYMBOL(vzalloc);
@@ -3469,7 +3470,7 @@ EXPORT_SYMBOL(vzalloc);
  *
  * Return: pointer to the allocated memory or %NULL on error
  */
-void *vmalloc_user(unsigned long size)
+__weak void *vmalloc_user(unsigned long size)
 {
 	return __vmalloc_node_range(size, SHMLBA,  VMALLOC_START, VMALLOC_END,
 				    GFP_KERNEL | __GFP_ZERO, PAGE_KERNEL,
@@ -3493,7 +3494,7 @@ EXPORT_SYMBOL(vmalloc_user);
  */
 void *vmalloc_node(unsigned long size, int node)
 {
-	return __vmalloc_node(size, 1, GFP_KERNEL, node,
+	return __vmalloc_node(size, 1, GFP_KERNEL, 0, node,
 			__builtin_return_address(0));
 }
 EXPORT_SYMBOL(vmalloc_node);
@@ -3511,23 +3512,11 @@ EXPORT_SYMBOL(vmalloc_node);
  */
 void *vzalloc_node(unsigned long size, int node)
 {
-	return __vmalloc_node(size, 1, GFP_KERNEL | __GFP_ZERO, node,
+	return __vmalloc_node(size, 1, GFP_KERNEL | __GFP_ZERO, 0, node,
 				__builtin_return_address(0));
 }
 EXPORT_SYMBOL(vzalloc_node);
 
-#if defined(CONFIG_64BIT) && defined(CONFIG_ZONE_DMA32)
-#define GFP_VMALLOC32 (GFP_DMA32 | GFP_KERNEL)
-#elif defined(CONFIG_64BIT) && defined(CONFIG_ZONE_DMA)
-#define GFP_VMALLOC32 (GFP_DMA | GFP_KERNEL)
-#else
-/*
- * 64b systems should always have either DMA or DMA32 zones. For others
- * GFP_DMA32 should do the right thing and use the normal zone.
- */
-#define GFP_VMALLOC32 (GFP_DMA32 | GFP_KERNEL)
-#endif
-
 /**
  * vmalloc_32 - allocate virtually contiguous memory (32bit addressable)
  * @size:	allocation size
@@ -3539,7 +3528,7 @@ EXPORT_SYMBOL(vzalloc_node);
  */
 void *vmalloc_32(unsigned long size)
 {
-	return __vmalloc_node(size, 1, GFP_VMALLOC32, NUMA_NO_NODE,
+	return __vmalloc_node(size, 1, GFP_VMALLOC32, 0, NUMA_NO_NODE,
 			__builtin_return_address(0));
 }
 EXPORT_SYMBOL(vmalloc_32);
@@ -3553,7 +3542,7 @@ EXPORT_SYMBOL(vmalloc_32);
  *
  * Return: pointer to the allocated memory or %NULL on error
  */
-void *vmalloc_32_user(unsigned long size)
+__weak void *vmalloc_32_user(unsigned long size)
 {
 	return __vmalloc_node_range(size, SHMLBA,  VMALLOC_START, VMALLOC_END,
 				    GFP_VMALLOC32 | __GFP_ZERO, PAGE_KERNEL,
-- 
2.39.2

