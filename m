Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91DE9320F66
	for <lists+linux-arch@lfdr.de>; Mon, 22 Feb 2021 03:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbhBVC2V convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Sun, 21 Feb 2021 21:28:21 -0500
Received: from mail.loongson.cn ([114.242.206.163]:56168 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230169AbhBVC2V (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 21 Feb 2021 21:28:21 -0500
Received: from [127.0.0.1] (unknown [182.149.161.179])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxTex7FjNgaxkNAA--.3531S2;
        Mon, 22 Feb 2021 10:27:09 +0800 (CST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Mailer: BlackBerry Email (10.3.3.3216)
Message-ID: <20210222022708.5771351.7345.9409@loongson.cn>
Date:   Mon, 22 Feb 2021 10:27:08 +0800
Subject: Re: [PATCH] MIPS: clean up CONFIG_MIPS_PGD_CONTEXT handling
From:   =?utf-8?b?6buE5rKb?= <huangpei@loongson.cn>
In-Reply-To: <202102211947.zSMGb1s3-lkp@intel.com>
References: <20210221022659.24146-1-huangpei@loongson.cn>
 <202102211947.zSMGb1s3-lkp@intel.com>
To:     kernel test robot <lkp@intel.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        ambrosehua@gmail.com
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        Bibo Mao <maobibo@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>
X-CM-TRANSID: AQAAf9BxTex7FjNgaxkNAA--.3531S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKr47ZFW7Cr18CFWkAw17GFg_yoWxGrW7pa
        4jqwn5CrsYvry5WFZrJFs7WF15Kw4DArZxXF1DG34qvFWYvF1rKrn2kr4avr1DJFs2vay2
        qr4vqr1rKw1qkaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
        4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
        628vn2kIc2xKxwCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyU
        JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUO_MaUUUUU
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, jiaxun,

It seems on 32 bit kernel, patch cause warning, but 32bit MIPS

** ‎need **CP0 Contextconfig configuration to enlarge the 

PTEBase field. Currently MIPS‎ Kconfig did not use MIPS 

_PGD_C0_CONTEXT on 32 bit CPU. Can we just ignore this 

warning?

  Original Message  
‎
From: kernel test robot
Sent: 2021年2月21日星期日 19:22
To: Huang Pei; Thomas Bogendoerfer; ambrosehua@gmail.com
Cc: kbuild-all@lists.01.org; clang-built-linux@googlegroups.com; Bibo Mao; Andrew Morton; Linux Memory Management List; linux-mips@vger.kernel.org; linux-arch@vger.kernel.org; Jiaxun Yang; Paul Burton; Li Xuefeng
Subject: Re: [PATCH] MIPS: clean up CONFIG_MIPS_PGD_CONTEXT handling

Hi Huang,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.11 next-20210219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url: https://github.com/0day-ci/linux/commits/Huang-Pei/MIPS-clean-up-CONFIG_MIPS_PGD_CONTEXT-handling/20210221-102942
base: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git f40ddce88593482919761f74910f42f4b84c004b
config: mips-randconfig-r021-20210221 (attached as .config)
compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project c9439ca36342fb6013187d0a69aef92736951476)
reproduce (this is a W=1 build):
wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
chmod +x ~/bin/make.cross
# install mips cross compiling tool for clang build
# apt-get install binutils-mips-linux-gnu
# https://github.com/0day-ci/linux/commit/e9601358443c6579f0fb63deee9a172d2bd03c57
git remote add linux-review https://github.com/0day-ci/linux
git fetch --no-tags linux-review Huang-Pei/MIPS-clean-up-CONFIG_MIPS_PGD_CONTEXT-handling/20210221-102942
git checkout e9601358443c6579f0fb63deee9a172d2bd03c57
# save the attached .config to linux build tree
COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/mips/mm/tlbex.c:1168:37: warning: shift count >= width of type [-Wshift-count-overflow]
uasm_i_ori(p, ptr, ptr, (CAC_BASE >> 53));
^ ~~
arch/mips/mm/tlbex.c:2605:6: warning: no previous prototype for function 'build_tlb_refill_handler' [-Wmissing-prototypes]
void build_tlb_refill_handler(void)
^
arch/mips/mm/tlbex.c:2605:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
void build_tlb_refill_handler(void)
^
static 
arch/mips/mm/tlbex.c:185:1: warning: unused function 'uasm_l_second_part' [-Wunused-function]
UASM_L_LA(_second_part)
^
arch/mips/include/asm/uasm.h:204:20: note: expanded from macro 'UASM_L_LA'
static inline void uasm_l##lb(struct uasm_label **lab, u32 *addr) \
^
<scratch space>:46:1: note: expanded from here
uasm_l_second_part
^
arch/mips/mm/tlbex.c:192:1: warning: unused function 'uasm_l_tlbl_goaround2' [-Wunused-function]
UASM_L_LA(_tlbl_goaround2)
^
arch/mips/include/asm/uasm.h:204:20: note: expanded from macro 'UASM_L_LA'
static inline void uasm_l##lb(struct uasm_label **lab, u32 *addr) \
^
<scratch space>:58:1: note: expanded from here
uasm_l_tlbl_goaround2
^
arch/mips/mm/tlbex.c:196:1: warning: unused function 'uasm_l_smp_pgtable_change' [-Wunused-function]
UASM_L_LA(_smp_pgtable_change)
^
arch/mips/include/asm/uasm.h:204:20: note: expanded from macro 'UASM_L_LA'
static inline void uasm_l##lb(struct uasm_label **lab, u32 *addr) \
^
<scratch space>:66:1: note: expanded from here
uasm_l_smp_pgtable_change
^
5 warnings generated.


vim +1168 arch/mips/mm/tlbex.c

1108	
1109	static struct mips_huge_tlb_info
1110	build_fast_tlb_refill_handler (u32 **p, struct uasm_label **l,
1111	 struct uasm_reloc **r, unsigned int tmp,
1112	 unsigned int ptr, int c0_scratch_reg)
1113	{
1114	 struct mips_huge_tlb_info rv;
1115	 unsigned int even, odd;
1116	 int vmalloc_branch_delay_filled = 0;
1117	 const int scratch = 1; /* Our extra working register */
1118	
1119	 rv.huge_pte = scratch;
1120	 rv.restore_scratch = 0;
1121	 rv.need_reload_pte = false;
1122	
1123	 if (check_for_high_segbits) {
1124	 UASM_i_MFC0(p, tmp, C0_BADVADDR);
1125	
1126	 if (pgd_reg != -1)
1127	 UASM_i_MFC0(p, ptr, c0_kscratch(), pgd_reg);
1128	 else
1129	 UASM_i_MFC0(p, ptr, C0_CONTEXT);
1130	
1131	 if (c0_scratch_reg >= 0)
1132	 UASM_i_MTC0(p, scratch, c0_kscratch(), c0_scratch_reg);
1133	 else
1134	 UASM_i_SW(p, scratch, scratchpad_offset(0), 0);
1135	
1136	 uasm_i_dsrl_safe(p, scratch, tmp,
1137	 PGDIR_SHIFT + PGD_ORDER + PAGE_SHIFT - 3);
1138	 uasm_il_bnez(p, r, scratch, label_vmalloc);
1139	
1140	 if (pgd_reg == -1) {
1141	 vmalloc_branch_delay_filled = 1;
1142	 /* Clear lower 23 bits of context. */
1143	 uasm_i_dins(p, ptr, 0, 0, 23);
1144	 }
1145	 } else {
1146	 if (pgd_reg != -1)
1147	 UASM_i_MFC0(p, ptr, c0_kscratch(), pgd_reg);
1148	 else
1149	 UASM_i_MFC0(p, ptr, C0_CONTEXT);
1150	
1151	 UASM_i_MFC0(p, tmp, C0_BADVADDR);
1152	
1153	 if (c0_scratch_reg >= 0)
1154	 UASM_i_MTC0(p, scratch, c0_kscratch(), c0_scratch_reg);
1155	 else
1156	 UASM_i_SW(p, scratch, scratchpad_offset(0), 0);
1157	
1158	 if (pgd_reg == -1)
1159	 /* Clear lower 23 bits of context. */
1160	 uasm_i_dins(p, ptr, 0, 0, 23);
1161	
1162	 uasm_il_bltz(p, r, tmp, label_vmalloc);
1163	 }
1164	
1165	 if (pgd_reg == -1) {
1166	 vmalloc_branch_delay_filled = 1;
1167	 /* insert bit[63:59] of CAC_BASE into bit[11:6] of ptr */
> 1168	 uasm_i_ori(p, ptr, ptr, (CAC_BASE >> 53));
1169	 uasm_i_drotr(p, ptr, ptr, 11);
1170	 }
1171	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

