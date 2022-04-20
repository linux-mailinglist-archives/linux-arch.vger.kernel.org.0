Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96909508B53
	for <lists+linux-arch@lfdr.de>; Wed, 20 Apr 2022 16:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354182AbiDTPBE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Apr 2022 11:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236824AbiDTPBD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Apr 2022 11:01:03 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4E93CFE8;
        Wed, 20 Apr 2022 07:58:16 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:53034)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nhBmW-00EbKN-HC; Wed, 20 Apr 2022 08:58:12 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35012 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nhBmU-003bgC-MQ; Wed, 20 Apr 2022 08:58:12 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mike Frysinger <vapier@gentoo.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        <linux-arch@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
References: <20220414091018.896737-1-niklas.cassel@wdc.com>
        <f379cb56-6ff5-f256-d5f2-3718a47e976d@opensource.wdc.com>
        <Yli8voX7hw3EZ7E/@x1-carbon>
        <81788b56-5b15-7308-38c7-c7f2502c4e15@linux-m68k.org>
Date:   Wed, 20 Apr 2022 09:58:03 -0500
In-Reply-To: <81788b56-5b15-7308-38c7-c7f2502c4e15@linux-m68k.org> (Greg
        Ungerer's message of "Wed, 20 Apr 2022 14:04:19 +1000")
Message-ID: <87levzzts4.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nhBmU-003bgC-MQ;;;mid=<87levzzts4.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19xj4mH8QFkZyqVzLNbiaR/zj+62dxVLTw=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1186 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.3 (0.4%), b_tie_ro: 2.9 (0.2%), parse: 2.1
        (0.2%), extract_message_metadata: 18 (1.5%), get_uri_detail_list: 7
        (0.6%), tests_pri_-1000: 12 (1.0%), tests_pri_-950: 1.10 (0.1%),
        tests_pri_-900: 0.86 (0.1%), tests_pri_-90: 250 (21.1%), check_bayes:
        248 (20.9%), b_tokenize: 21 (1.8%), b_tok_get_all: 126 (10.6%),
        b_comp_prob: 4.8 (0.4%), b_tok_touch_all: 92 (7.8%), b_finish: 0.76
        (0.1%), tests_pri_0: 883 (74.4%), check_dkim_signature: 0.59 (0.0%),
        check_dkim_adsp: 2.7 (0.2%), poll_dns_idle: 1.33 (0.1%), tests_pri_10:
        2.7 (0.2%), tests_pri_500: 8 (0.7%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH] binfmt_flat: Remove shared library support
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


In a recent discussion[1] it was reported that the binfmt_flat library
support was only ever used on m68k and even on m68k has not been used
in a very long time.

The structure of binfmt_flat is different from all of the other binfmt
implementations becasue of this shared library support and it made
life and code review more effort when I refactored the code in fs/exec.c.

Since in practice the code is dead remove the binfmt_flat shared libarary
support and make maintenance of the code easier.

[1] https://lkml.kernel.org/r/81788b56-5b15-7308-38c7-c7f2502c4e15@linux-m68k.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---

Can the binfmt_flat folks please verify that the shared library support
really isn't used?

Was binfmt_flat being enabled on arm and sh the mistake it looks like?

 arch/arm/configs/lpc18xx_defconfig |   1 -
 arch/arm/configs/mps2_defconfig    |   1 -
 arch/arm/configs/stm32_defconfig   |   1 -
 arch/arm/configs/vf610m4_defconfig |   1 -
 arch/sh/configs/rsk7201_defconfig  |   1 -
 arch/sh/configs/rsk7203_defconfig  |   1 -
 arch/sh/configs/se7206_defconfig   |   1 -
 fs/Kconfig.binfmt                  |   6 -
 fs/binfmt_flat.c                   | 190 ++++++-----------------------
 9 files changed, 40 insertions(+), 163 deletions(-)

diff --git a/arch/arm/configs/lpc18xx_defconfig b/arch/arm/configs/lpc18xx_defconfig
index be882ea0eee4..688c9849eec8 100644
--- a/arch/arm/configs/lpc18xx_defconfig
+++ b/arch/arm/configs/lpc18xx_defconfig
@@ -30,7 +30,6 @@ CONFIG_ARM_APPENDED_DTB=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_BINFMT_FLAT=y
 CONFIG_BINFMT_ZFLAT=y
-CONFIG_BINFMT_SHARED_FLAT=y
 # CONFIG_COREDUMP is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/arm/configs/mps2_defconfig b/arch/arm/configs/mps2_defconfig
index 89f4a6ff30bd..c1e98e33a348 100644
--- a/arch/arm/configs/mps2_defconfig
+++ b/arch/arm/configs/mps2_defconfig
@@ -23,7 +23,6 @@ CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_BINFMT_FLAT=y
-CONFIG_BINFMT_SHARED_FLAT=y
 # CONFIG_COREDUMP is not set
 # CONFIG_SUSPEND is not set
 CONFIG_NET=y
diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index 551db328009d..71d6bfcf4551 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -28,7 +28,6 @@ CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_XIP_KERNEL=y
 CONFIG_XIP_PHYS_ADDR=0x08008000
 CONFIG_BINFMT_FLAT=y
-CONFIG_BINFMT_SHARED_FLAT=y
 # CONFIG_COREDUMP is not set
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
diff --git a/arch/arm/configs/vf610m4_defconfig b/arch/arm/configs/vf610m4_defconfig
index a89f035c3b01..70fdbfd83484 100644
--- a/arch/arm/configs/vf610m4_defconfig
+++ b/arch/arm/configs/vf610m4_defconfig
@@ -18,7 +18,6 @@ CONFIG_XIP_KERNEL=y
 CONFIG_XIP_PHYS_ADDR=0x0f000080
 CONFIG_BINFMT_FLAT=y
 CONFIG_BINFMT_ZFLAT=y
-CONFIG_BINFMT_SHARED_FLAT=y
 # CONFIG_SUSPEND is not set
 # CONFIG_UEVENT_HELPER is not set
 # CONFIG_STANDALONE is not set
diff --git a/arch/sh/configs/rsk7201_defconfig b/arch/sh/configs/rsk7201_defconfig
index e41526120be1..619c18699459 100644
--- a/arch/sh/configs/rsk7201_defconfig
+++ b/arch/sh/configs/rsk7201_defconfig
@@ -25,7 +25,6 @@ CONFIG_CMDLINE_OVERWRITE=y
 CONFIG_CMDLINE="console=ttySC0,115200 earlyprintk=serial ignore_loglevel"
 CONFIG_BINFMT_FLAT=y
 CONFIG_BINFMT_ZFLAT=y
-CONFIG_BINFMT_SHARED_FLAT=y
 CONFIG_PM=y
 CONFIG_CPU_IDLE=y
 # CONFIG_STANDALONE is not set
diff --git a/arch/sh/configs/rsk7203_defconfig b/arch/sh/configs/rsk7203_defconfig
index 6af08fa1ddf8..5a54e2b883f0 100644
--- a/arch/sh/configs/rsk7203_defconfig
+++ b/arch/sh/configs/rsk7203_defconfig
@@ -30,7 +30,6 @@ CONFIG_CMDLINE_OVERWRITE=y
 CONFIG_CMDLINE="console=ttySC0,115200 earlyprintk=serial ignore_loglevel"
 CONFIG_BINFMT_FLAT=y
 CONFIG_BINFMT_ZFLAT=y
-CONFIG_BINFMT_SHARED_FLAT=y
 CONFIG_PM=y
 CONFIG_CPU_IDLE=y
 CONFIG_NET=y
diff --git a/arch/sh/configs/se7206_defconfig b/arch/sh/configs/se7206_defconfig
index 601d062250d1..122216123e63 100644
--- a/arch/sh/configs/se7206_defconfig
+++ b/arch/sh/configs/se7206_defconfig
@@ -40,7 +40,6 @@ CONFIG_CMDLINE_OVERWRITE=y
 CONFIG_CMDLINE="console=ttySC3,115200 ignore_loglevel earlyprintk=serial"
 CONFIG_BINFMT_FLAT=y
 CONFIG_BINFMT_ZFLAT=y
-CONFIG_BINFMT_SHARED_FLAT=y
 CONFIG_BINFMT_MISC=y
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 21c6332fa785..32dff7ba3dda 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -142,12 +142,6 @@ config BINFMT_ZFLAT
 	help
 	  Support FLAT format compressed binaries
 
-config BINFMT_SHARED_FLAT
-	bool "Enable shared FLAT support"
-	depends on BINFMT_FLAT
-	help
-	  Support FLAT shared libraries
-
 config HAVE_AOUT
        def_bool n
 
diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index 0ad2c7bbaddd..82e4412a9665 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -68,11 +68,7 @@
 #define RELOC_FAILED 0xff00ff01		/* Relocation incorrect somewhere */
 #define UNLOADED_LIB 0x7ff000ff		/* Placeholder for unused library */
 
-#ifdef CONFIG_BINFMT_SHARED_FLAT
-#define	MAX_SHARED_LIBS			(4)
-#else
-#define	MAX_SHARED_LIBS			(1)
-#endif
+#define MAX_SHARED_LIBS			(1)
 
 #ifdef CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET
 #define DATA_START_OFFSET_WORDS		(0)
@@ -92,10 +88,6 @@ struct lib_info {
 	} lib_list[MAX_SHARED_LIBS];
 };
 
-#ifdef CONFIG_BINFMT_SHARED_FLAT
-static int load_flat_shared_library(int id, struct lib_info *p);
-#endif
-
 static int load_flat_binary(struct linux_binprm *);
 
 static struct linux_binfmt flat_format = {
@@ -307,51 +299,18 @@ static int decompress_exec(struct linux_binprm *bprm, loff_t fpos, char *dst,
 /****************************************************************************/
 
 static unsigned long
-calc_reloc(unsigned long r, struct lib_info *p, int curid, int internalp)
+calc_reloc(unsigned long r, struct lib_info *p)
 {
 	unsigned long addr;
-	int id;
 	unsigned long start_brk;
 	unsigned long start_data;
 	unsigned long text_len;
 	unsigned long start_code;
 
-#ifdef CONFIG_BINFMT_SHARED_FLAT
-	if (r == 0)
-		id = curid;	/* Relocs of 0 are always self referring */
-	else {
-		id = (r >> 24) & 0xff;	/* Find ID for this reloc */
-		r &= 0x00ffffff;	/* Trim ID off here */
-	}
-	if (id >= MAX_SHARED_LIBS) {
-		pr_err("reference 0x%lx to shared library %d", r, id);
-		goto failed;
-	}
-	if (curid != id) {
-		if (internalp) {
-			pr_err("reloc address 0x%lx not in same module "
-			       "(%d != %d)", r, curid, id);
-			goto failed;
-		} else if (!p->lib_list[id].loaded &&
-			   load_flat_shared_library(id, p) < 0) {
-			pr_err("failed to load library %d", id);
-			goto failed;
-		}
-		/* Check versioning information (i.e. time stamps) */
-		if (p->lib_list[id].build_date && p->lib_list[curid].build_date &&
-				p->lib_list[curid].build_date < p->lib_list[id].build_date) {
-			pr_err("library %d is younger than %d", id, curid);
-			goto failed;
-		}
-	}
-#else
-	id = 0;
-#endif
-
-	start_brk = p->lib_list[id].start_brk;
-	start_data = p->lib_list[id].start_data;
-	start_code = p->lib_list[id].start_code;
-	text_len = p->lib_list[id].text_len;
+	start_brk = p->lib_list[0].start_brk;
+	start_data = p->lib_list[0].start_data;
+	start_code = p->lib_list[0].start_code;
+	text_len = p->lib_list[0].text_len;
 
 	if (r > start_brk - start_data + text_len) {
 		pr_err("reloc outside program 0x%lx (0 - 0x%lx/0x%lx)",
@@ -419,7 +378,7 @@ static void old_reloc(unsigned long rl)
 /****************************************************************************/
 
 static int load_flat_file(struct linux_binprm *bprm,
-		struct lib_info *libinfo, int id, unsigned long *extra_stack)
+		struct lib_info *libinfo, unsigned long *extra_stack)
 {
 	struct flat_hdr *hdr;
 	unsigned long textpos, datapos, realdatastart;
@@ -471,14 +430,6 @@ static int load_flat_file(struct linux_binprm *bprm,
 		goto err;
 	}
 
-	/* Don't allow old format executables to use shared libraries */
-	if (rev == OLD_FLAT_VERSION && id != 0) {
-		pr_err("shared libraries are not available before rev 0x%lx\n",
-		       FLAT_VERSION);
-		ret = -ENOEXEC;
-		goto err;
-	}
-
 	/*
 	 * fix up the flags for the older format,  there were all kinds
 	 * of endian hacks,  this only works for the simple cases
@@ -529,15 +480,13 @@ static int load_flat_file(struct linux_binprm *bprm,
 	}
 
 	/* Flush all traces of the currently running executable */
-	if (id == 0) {
-		ret = begin_new_exec(bprm);
-		if (ret)
-			goto err;
+	ret = begin_new_exec(bprm);
+	if (ret)
+		goto err;
 
-		/* OK, This is the point of no return */
-		set_personality(PER_LINUX_32BIT);
-		setup_new_exec(bprm);
-	}
+	/* OK, This is the point of no return */
+	set_personality(PER_LINUX_32BIT);
+	setup_new_exec(bprm);
 
 	/*
 	 * calculate the extra space we need to map in
@@ -717,42 +666,40 @@ static int load_flat_file(struct linux_binprm *bprm,
 	text_len -= sizeof(struct flat_hdr); /* the real code len */
 
 	/* The main program needs a little extra setup in the task structure */
-	if (id == 0) {
-		current->mm->start_code = start_code;
-		current->mm->end_code = end_code;
-		current->mm->start_data = datapos;
-		current->mm->end_data = datapos + data_len;
-		/*
-		 * set up the brk stuff, uses any slack left in data/bss/stack
-		 * allocation.  We put the brk after the bss (between the bss
-		 * and stack) like other platforms.
-		 * Userspace code relies on the stack pointer starting out at
-		 * an address right at the end of a page.
-		 */
-		current->mm->start_brk = datapos + data_len + bss_len;
-		current->mm->brk = (current->mm->start_brk + 3) & ~3;
+	current->mm->start_code = start_code;
+	current->mm->end_code = end_code;
+	current->mm->start_data = datapos;
+	current->mm->end_data = datapos + data_len;
+	/*
+	 * set up the brk stuff, uses any slack left in data/bss/stack
+	 * allocation.  We put the brk after the bss (between the bss
+	 * and stack) like other platforms.
+	 * Userspace code relies on the stack pointer starting out at
+	 * an address right at the end of a page.
+	 */
+	current->mm->start_brk = datapos + data_len + bss_len;
+	current->mm->brk = (current->mm->start_brk + 3) & ~3;
 #ifndef CONFIG_MMU
-		current->mm->context.end_brk = memp + memp_size - stack_len;
+	current->mm->context.end_brk = memp + memp_size - stack_len;
 #endif
-	}
 
 	if (flags & FLAT_FLAG_KTRACE) {
 		pr_info("Mapping is %lx, Entry point is %x, data_start is %x\n",
 			textpos, 0x00ffffff&ntohl(hdr->entry), ntohl(hdr->data_start));
 		pr_info("%s %s: TEXT=%lx-%lx DATA=%lx-%lx BSS=%lx-%lx\n",
-			id ? "Lib" : "Load", bprm->filename,
+			"Load", bprm->filename,
 			start_code, end_code, datapos, datapos + data_len,
 			datapos + data_len, (datapos + data_len + bss_len + 3) & ~3);
 	}
 
 	/* Store the current module values into the global library structure */
-	libinfo->lib_list[id].start_code = start_code;
-	libinfo->lib_list[id].start_data = datapos;
-	libinfo->lib_list[id].start_brk = datapos + data_len + bss_len;
-	libinfo->lib_list[id].text_len = text_len;
-	libinfo->lib_list[id].loaded = 1;
-	libinfo->lib_list[id].entry = (0x00ffffff & ntohl(hdr->entry)) + textpos;
-	libinfo->lib_list[id].build_date = ntohl(hdr->build_date);
+	libinfo->lib_list[0].start_code = start_code;
+	libinfo->lib_list[0].start_data = datapos;
+	libinfo->lib_list[0].start_brk = datapos + data_len + bss_len;
+	libinfo->lib_list[0].text_len = text_len;
+	libinfo->lib_list[0].loaded = 1;
+	libinfo->lib_list[0].entry = (0x00ffffff & ntohl(hdr->entry)) + textpos;
+	libinfo->lib_list[0].build_date = ntohl(hdr->build_date);
 
 	/*
 	 * We just load the allocations into some temporary memory to
@@ -774,7 +721,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 			if (rp_val == 0xffffffff)
 				break;
 			if (rp_val) {
-				addr = calc_reloc(rp_val, libinfo, id, 0);
+				addr = calc_reloc(rp_val, libinfo);
 				if (addr == RELOC_FAILED) {
 					ret = -ENOEXEC;
 					goto err;
@@ -810,7 +757,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 				return -EFAULT;
 			relval = ntohl(tmp);
 			addr = flat_get_relocate_addr(relval);
-			rp = (u32 __user *)calc_reloc(addr, libinfo, id, 1);
+			rp = (u32 __user *)calc_reloc(addr, libinfo);
 			if (rp == (u32 __user *)RELOC_FAILED) {
 				ret = -ENOEXEC;
 				goto err;
@@ -833,7 +780,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 					 */
 					addr = ntohl((__force __be32)addr);
 				}
-				addr = calc_reloc(addr, libinfo, id, 0);
+				addr = calc_reloc(addr, libinfo);
 				if (addr == RELOC_FAILED) {
 					ret = -ENOEXEC;
 					goto err;
@@ -861,7 +808,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 	/* zero the BSS,  BRK and stack areas */
 	if (clear_user((void __user *)(datapos + data_len), bss_len +
 		       (memp + memp_size - stack_len -		/* end brk */
-		       libinfo->lib_list[id].start_brk) +	/* start brk */
+		       libinfo->lib_list[0].start_brk) +	/* start brk */
 		       stack_len))
 		return -EFAULT;
 
@@ -871,49 +818,6 @@ static int load_flat_file(struct linux_binprm *bprm,
 }
 
 
-/****************************************************************************/
-#ifdef CONFIG_BINFMT_SHARED_FLAT
-
-/*
- * Load a shared library into memory.  The library gets its own data
- * segment (including bss) but not argv/argc/environ.
- */
-
-static int load_flat_shared_library(int id, struct lib_info *libs)
-{
-	/*
-	 * This is a fake bprm struct; only the members "buf", "file" and
-	 * "filename" are actually used.
-	 */
-	struct linux_binprm bprm;
-	int res;
-	char buf[16];
-	loff_t pos = 0;
-
-	memset(&bprm, 0, sizeof(bprm));
-
-	/* Create the file name */
-	sprintf(buf, "/lib/lib%d.so", id);
-
-	/* Open the file up */
-	bprm.filename = buf;
-	bprm.file = open_exec(bprm.filename);
-	res = PTR_ERR(bprm.file);
-	if (IS_ERR(bprm.file))
-		return res;
-
-	res = kernel_read(bprm.file, bprm.buf, BINPRM_BUF_SIZE, &pos);
-
-	if (res >= 0)
-		res = load_flat_file(&bprm, libs, id, NULL);
-
-	allow_write_access(bprm.file);
-	fput(bprm.file);
-
-	return res;
-}
-
-#endif /* CONFIG_BINFMT_SHARED_FLAT */
 /****************************************************************************/
 
 /*
@@ -946,7 +850,7 @@ static int load_flat_binary(struct linux_binprm *bprm)
 	stack_len += (bprm->envc + 1) * sizeof(char *);   /* the envp array */
 	stack_len = ALIGN(stack_len, FLAT_STACK_ALIGN);
 
-	res = load_flat_file(bprm, &libinfo, 0, &stack_len);
+	res = load_flat_file(bprm, &libinfo, &stack_len);
 	if (res < 0)
 		return res;
 
@@ -991,20 +895,6 @@ static int load_flat_binary(struct linux_binprm *bprm)
 	 */
 	start_addr = libinfo.lib_list[0].entry;
 
-#ifdef CONFIG_BINFMT_SHARED_FLAT
-	for (i = MAX_SHARED_LIBS-1; i > 0; i--) {
-		if (libinfo.lib_list[i].loaded) {
-			/* Push previos first to call address */
-			unsigned long __user *sp;
-			current->mm->start_stack -= sizeof(unsigned long);
-			sp = (unsigned long __user *)current->mm->start_stack;
-			if (put_user(start_addr, sp))
-				return -EFAULT;
-			start_addr = libinfo.lib_list[i].entry;
-		}
-	}
-#endif
-
 #ifdef FLAT_PLAT_INIT
 	FLAT_PLAT_INIT(regs);
 #endif
-- 
2.35.3

