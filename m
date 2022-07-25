Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783E25804BD
	for <lists+linux-arch@lfdr.de>; Mon, 25 Jul 2022 21:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236407AbiGYTtS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Jul 2022 15:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236414AbiGYTtL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Jul 2022 15:49:11 -0400
X-Greylist: delayed 360 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Jul 2022 12:49:07 PDT
Received: from server.lespinasse.org (server.lespinasse.org [63.205.204.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B760205D5;
        Mon, 25 Jul 2022 12:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-78-ed;
 t=1658778186; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=G+HAStA9EHnsDI70V3dAV7pog8N1VgTExz3TxhNjpNA=;
 b=PUonlSYHBmxO3XTVIYRAd2vU3rmLOQyp6Sfrv1oYCByaa8fxeg5VfvvbOFafuKlR4pnlq
 /UEBminQTAvEphABA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-78-rsa; t=1658778186; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=G+HAStA9EHnsDI70V3dAV7pog8N1VgTExz3TxhNjpNA=;
 b=V2febsr7b9mkuWEe8ZOqoyPy0TuKQXQ7mM1Z2B6zBbFzk0TChXGE+rOfv88S7GjFAbKBd
 1Y5YftvwaniQh9eKbf0Ah91pEKMK5D66+BdY4dngOb/MsV+G2V5lHMU/xCOUlm58RaY47ny
 JYEX/1abh0RbCF5ykXjZUuRPnqmpQQ3xMIfTQ9nxED7uHRn1NZNrHvhOQvlyhHv8qil084L
 M3vg6V7kmpSuI7sL2cdvGmoA4Yeg+eSENUTP+PqzHwMotIWas5LBMFudNeSBWD5cvfIWVkI
 zSeF604Trtoy2A9GA+rc10I0jVN9uBkbuRiA0FqqMO9Yj7igivtFamhkf7/A==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id D99501607CF; Mon, 25 Jul 2022 12:43:06 -0700 (PDT)
Date:   Mon, 25 Jul 2022 12:43:06 -0700
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        vgupta@kernel.org, linux@armlinux.org.uk,
        ulli.kroll@googlemail.com, linus.walleij@linaro.org,
        shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com,
        will@kernel.org, guoren@kernel.org, bcain@quicinc.com,
        chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org,
        sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de,
        dinguyen@kernel.org, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        James.Bottomley@HansenPartnership.com, deller@gmx.de,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org,
        davem@davemloft.net, richard@nod.at,
        anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, jgross@suse.com, srivatsa@csail.mit.edu,
        amakhalov@vmware.com, pv-drivers@vmware.com,
        boris.ostrovsky@oracle.com, chris@zankel.net, jcmvbkbc@gmail.com,
        rafael@kernel.org, lenb@kernel.org, pavel@ucw.cz,
        gregkh@linuxfoundation.org, mturquette@baylibre.com,
        sboyd@kernel.org, daniel.lezcano@linaro.org, lpieralisi@kernel.org,
        sudeep.holla@arm.com, agross@kernel.org,
        bjorn.andersson@linaro.org, anup@brainfault.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        jacob.jun.pan@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, rostedt@goodmis.org, pmladek@suse.com,
        senozhatsky@chromium.org, john.ogness@linutronix.de,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, jpoimboe@kernel.org,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-perf-users@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-xtensa@linux-xtensa.org,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arch@vger.kernel.org,
        rcu@vger.kernel.org, rh0@fb.com
Subject: Re: [PATCH 04/36] cpuidle,intel_idle: Fix CPUIDLE_FLAG_IRQ_ENABLE
Message-ID: <20220725194306.GA14746@lespinasse.org>
References: <20220608142723.103523089@infradead.org>
 <20220608144516.172460444@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <20220608144516.172460444@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 08, 2022 at 04:27:27PM +0200, Peter Zijlstra wrote:
> Commit c227233ad64c ("intel_idle: enable interrupts before C1 on
> Xeons") wrecked intel_idle in two ways:
> 
>  - must not have tracing in idle functions
>  - must return with IRQs disabled
> 
> Additionally, it added a branch for no good reason.
> 
> Fixes: c227233ad64c ("intel_idle: enable interrupts before C1 on Xeons")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

After this change was introduced, I am seeing "WARNING: suspicious RCU
usage" when booting a kernel with debug options compiled in. Please
see the attached dmesg output. The issue starts with commit 32d4fd5751ea
and is still present in v5.19-rc8.

I'm not sure, is this too late to fix or revert in v5.19 final ?

Thanks,

--
Michel "walken" Lespinasse

--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

[    0.000000] microcode: microcode updated early to revision 0x2006d05, date = 2021-11-13
[    0.000000] Linux version 5.19.0-rc8-test-00003-ge3a8d97e6a35 (walken@zeus) (gcc (Debian 8.3.0-6) 8.3.0, GNU ld (GNU Binutils for Debian) 2.31.1) #1 SMP PREEMPT_DYNAMIC Mon Jul 25 00:32:16 PDT 2022
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-5.19.0-rc8-test-00003-ge3a8d97e6a35 root=/dev/mapper/budai--vg-root ro consoleblank=600 quiet
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: xstate_offset[5]:  960, xstate_sizes[5]:   64
[    0.000000] x86/fpu: xstate_offset[6]: 1024, xstate_sizes[6]:  512
[    0.000000] x86/fpu: xstate_offset[7]: 1536, xstate_sizes[7]: 1024
[    0.000000] x86/fpu: Enabled xstate features 0xff, context size is 2560 bytes, using 'compacted' format.
[    0.000000] signal: max sigframe size: 3632
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000003efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000003f000-0x000000000003ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000040000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000062a8efff] usable
[    0.000000] BIOS-e820: [mem 0x0000000062a8f000-0x000000006aef4fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000006aef5000-0x000000006b0c2fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000006b0c3000-0x000000006be0dfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000006be0e000-0x000000006c7f1fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000006c7f2000-0x000000006c8e5fff] type 20
[    0.000000] BIOS-e820: [mem 0x000000006c8e6000-0x000000006c8e6fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000006c8e7000-0x000000006c9a7fff] type 20
[    0.000000] BIOS-e820: [mem 0x000000006c9a8000-0x000000006e6fffff] usable
[    0.000000] BIOS-e820: [mem 0x000000006e700000-0x000000008fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fd000000-0x00000000fe010fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed20000-0x00000000fed44fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000107fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.70 by American Megatrends
[    0.000000] efi: TPMFinalLog=0x6bd97000 ACPI=0x6b0c2000 ACPI 2.0=0x6b0c2014 SMBIOS=0x6c47b000 SMBIOS 3.0=0x6c47a000 MEMATTR=0x5d04d018 ESRT=0x604e0718 
[    0.000000] SMBIOS 3.0.0 present.
[    0.000000] DMI: LENOVO 30BFS44D00/1036, BIOS S03KT51A 01/17/2022
[    0.000000] tsc: Detected 3700.000 MHz processor
[    0.000000] tsc: Detected 3699.850 MHz TSC
[    0.000278] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000281] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000289] last_pfn = 0x1080000 max_arch_pfn = 0x400000000
[    0.000397] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.001626] e820: update [mem 0x7e000000-0xffffffff] usable ==> reserved
[    0.001632] last_pfn = 0x6e700 max_arch_pfn = 0x400000000
[    0.007772] esrt: Reserving ESRT space from 0x00000000604e0718 to 0x00000000604e0778.
[    0.007776] e820: update [mem 0x604e0000-0x604e0fff] usable ==> reserved
[    0.118600] Secure boot could not be determined
[    0.118602] RAMDISK: [mem 0x3629b000-0x37144fff]
[    0.118605] ACPI: Early table checksum verification disabled
[    0.118608] ACPI: RSDP 0x000000006B0C2014 000024 (v02 LENOVO)
[    0.118612] ACPI: XSDT 0x000000006B0C1728 00013C (v01 LENOVO TC-S03   00001330 AMI  01000013)
[    0.118617] ACPI: FACP 0x000000006B0C0000 000114 (v06 LENOVO TC-S03   00001330 AMI  00010013)
[    0.118622] ACPI: DSDT 0x000000006AFFF000 0C0B0C (v02 LENOVO TC-S03   00001330 INTL 20160422)
[    0.118625] ACPI: FACS 0x000000006BD96000 000040
[    0.118628] ACPI: FIDT 0x000000006AFFE000 00009C (v01 LENOVO TC-S03   00001330 AMI  00010013)
[    0.118631] ACPI: MCFG 0x000000006AFFD000 00003C (v01 LENOVO TC-S03   00001330 MSFT 00000097)
[    0.118634] ACPI: HPET 0x000000006AFFC000 000038 (v01 LENOVO TC-S03   00001330 INTL 20091013)
[    0.118637] ACPI: APIC 0x000000006AFFB000 00071E (v03 LENOVO TC-S03   00001330 INTL 20091013)
[    0.118640] ACPI: MIGT 0x000000006AFFA000 000040 (v01 LENOVO TC-S03   00001330 INTL 20091013)
[    0.118643] ACPI: MSCT 0x000000006AFF9000 00004E (v01 LENOVO TC-S03   00001330 INTL 20091013)
[    0.118646] ACPI: PCAT 0x000000006AFF8000 000068 (v02 LENOVO TC-S03   00001330 INTL 20091013)
[    0.118649] ACPI: PCCT 0x000000006AFF7000 00006E (v01 LENOVO TC-S03   00001330 INTL 20091013)
[    0.118652] ACPI: RASF 0x000000006AFF6000 000030 (v01 LENOVO TC-S03   00001330 INTL 20091013)
[    0.118655] ACPI: SLIT 0x000000006AFF5000 00006C (v01 LENOVO TC-S03   00001330 INTL 20091013)
[    0.118657] ACPI: SRAT 0x000000006AFF4000 000B70 (v03 LENOVO TC-S03   00001330 INTL 20091013)
[    0.118660] ACPI: SVOS 0x000000006AFF3000 000032 (v01 LENOVO TC-S03   00001330 INTL 20091013)
[    0.118663] ACPI: WDDT 0x000000006AFF2000 000040 (v01 LENOVO TC-S03   00001330 INTL 20091013)
[    0.118666] ACPI: OEM4 0x000000006AFC8000 029A72 (v02 INTEL  CPU  CST 00003000 INTL 20160422)
[    0.118669] ACPI: OEM1 0x000000006AFBD000 00ABCB (v02 INTEL  CPU EIST 00003000 INTL 20160422)
[    0.118672] ACPI: OEM2 0x000000006AFAB000 011208 (v02 INTEL  CPU  HWP 00003000 INTL 20160422)
[    0.118675] ACPI: SSDT 0x000000006AF9D000 00D427 (v02 LENOVO TC-S03   00001330 INTL 20160422)
[    0.118678] ACPI: NITR 0x000000006AF9C000 000071 (v02 LENOVO TC-S03   00001330 INTL 20091013)
[    0.118681] ACPI: LPIT 0x000000006AF9A000 000094 (v01 LENOVO TC-S03   00001330 MSFT 0000005F)
[    0.118684] ACPI: WDAT 0x000000006AF98000 000134 (v01 LENOVO TC-S03   00001330 MSFT 0000005F)
[    0.118687] ACPI: SSDT 0x000000006AF94000 003002 (v02 LENOVO TC-S03   00001330 INTL 20160422)
[    0.118690] ACPI: DBGP 0x000000006AF93000 000034 (v01 LENOVO TC-S03   00001330 MSFT 0000005F)
[    0.118693] ACPI: DBG2 0x000000006AF92000 000054 (v00 LENOVO TC-S03   00001330 MSFT 0000005F)
[    0.118696] ACPI: BGRT 0x000000006AF91000 000038 (v01 LENOVO TC-S03   00001330 AMI  00010013)
[    0.118699] ACPI: TPM2 0x000000006AF90000 00004C (v03 LENOVO TC-S03   00001330 AMI  00000000)
[    0.118701] ACPI: LUFT 0x000000006AF5B000 0349E2 (v01 LENOVO TC-S03   00001330 AMI  00010013)
[    0.118704] ACPI: HEST 0x000000006AF5A000 0000A8 (v01 LENOVO TC-S03   00001330 INTL 00000001)
[    0.118707] ACPI: BERT 0x000000006AF59000 000030 (v01 LENOVO TC-S03   00001330 INTL 00000001)
[    0.118710] ACPI: ERST 0x000000006AF58000 000230 (v01 LENOVO TC-S03   00001330 INTL 00000001)
[    0.118713] ACPI: EINJ 0x000000006AF57000 000150 (v01 LENOVO TC-S03   00001330 INTL 00000001)
[    0.118716] ACPI: ASF! 0x000000006AF56000 0000A0 (v32 LENOVO TC-S03   00001330 TFSM 000F4240)
[    0.118719] ACPI: WSMT 0x000000006AF99000 000028 (v01 LENOVO TC-S03   00001330 AMI  00010013)
[    0.118722] ACPI: SSDT 0x000000006AF9B000 000ACE (v02 LENOVO TC-S03   00001330 INTL 20091013)
[    0.118725] ACPI: FPDT 0x000000006AF54000 000044 (v01 LENOVO TC-S03   00001330 AMI  01000013)
[    0.118727] ACPI: Reserving FACP table memory at [mem 0x6b0c0000-0x6b0c0113]
[    0.118729] ACPI: Reserving DSDT table memory at [mem 0x6afff000-0x6b0bfb0b]
[    0.118730] ACPI: Reserving FACS table memory at [mem 0x6bd96000-0x6bd9603f]
[    0.118731] ACPI: Reserving FIDT table memory at [mem 0x6affe000-0x6affe09b]
[    0.118732] ACPI: Reserving MCFG table memory at [mem 0x6affd000-0x6affd03b]
[    0.118733] ACPI: Reserving HPET table memory at [mem 0x6affc000-0x6affc037]
[    0.118734] ACPI: Reserving APIC table memory at [mem 0x6affb000-0x6affb71d]
[    0.118735] ACPI: Reserving MIGT table memory at [mem 0x6affa000-0x6affa03f]
[    0.118736] ACPI: Reserving MSCT table memory at [mem 0x6aff9000-0x6aff904d]
[    0.118737] ACPI: Reserving PCAT table memory at [mem 0x6aff8000-0x6aff8067]
[    0.118737] ACPI: Reserving PCCT table memory at [mem 0x6aff7000-0x6aff706d]
[    0.118738] ACPI: Reserving RASF table memory at [mem 0x6aff6000-0x6aff602f]
[    0.118739] ACPI: Reserving SLIT table memory at [mem 0x6aff5000-0x6aff506b]
[    0.118740] ACPI: Reserving SRAT table memory at [mem 0x6aff4000-0x6aff4b6f]
[    0.118741] ACPI: Reserving SVOS table memory at [mem 0x6aff3000-0x6aff3031]
[    0.118742] ACPI: Reserving WDDT table memory at [mem 0x6aff2000-0x6aff203f]
[    0.118743] ACPI: Reserving OEM4 table memory at [mem 0x6afc8000-0x6aff1a71]
[    0.118744] ACPI: Reserving OEM1 table memory at [mem 0x6afbd000-0x6afc7bca]
[    0.118745] ACPI: Reserving OEM2 table memory at [mem 0x6afab000-0x6afbc207]
[    0.118746] ACPI: Reserving SSDT table memory at [mem 0x6af9d000-0x6afaa426]
[    0.118747] ACPI: Reserving NITR table memory at [mem 0x6af9c000-0x6af9c070]
[    0.118748] ACPI: Reserving LPIT table memory at [mem 0x6af9a000-0x6af9a093]
[    0.118749] ACPI: Reserving WDAT table memory at [mem 0x6af98000-0x6af98133]
[    0.118750] ACPI: Reserving SSDT table memory at [mem 0x6af94000-0x6af97001]
[    0.118751] ACPI: Reserving DBGP table memory at [mem 0x6af93000-0x6af93033]
[    0.118752] ACPI: Reserving DBG2 table memory at [mem 0x6af92000-0x6af92053]
[    0.118753] ACPI: Reserving BGRT table memory at [mem 0x6af91000-0x6af91037]
[    0.118754] ACPI: Reserving TPM2 table memory at [mem 0x6af90000-0x6af9004b]
[    0.118755] ACPI: Reserving LUFT table memory at [mem 0x6af5b000-0x6af8f9e1]
[    0.118756] ACPI: Reserving HEST table memory at [mem 0x6af5a000-0x6af5a0a7]
[    0.118757] ACPI: Reserving BERT table memory at [mem 0x6af59000-0x6af5902f]
[    0.118758] ACPI: Reserving ERST table memory at [mem 0x6af58000-0x6af5822f]
[    0.118759] ACPI: Reserving EINJ table memory at [mem 0x6af57000-0x6af5714f]
[    0.118760] ACPI: Reserving ASF! table memory at [mem 0x6af56000-0x6af5609f]
[    0.118760] ACPI: Reserving WSMT table memory at [mem 0x6af99000-0x6af99027]
[    0.118762] ACPI: Reserving SSDT table memory at [mem 0x6af9b000-0x6af9bacd]
[    0.118763] ACPI: Reserving FPDT table memory at [mem 0x6af54000-0x6af54043]
[    0.194241] Zone ranges:
[    0.194243]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.194245]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.194247]   Normal   [mem 0x0000000100000000-0x000000107fffffff]
[    0.194248] Movable zone start for each node
[    0.194249] Early memory node ranges
[    0.194250]   node   0: [mem 0x0000000000001000-0x000000000003efff]
[    0.194251]   node   0: [mem 0x0000000000040000-0x000000000009ffff]
[    0.194252]   node   0: [mem 0x0000000000100000-0x0000000062a8efff]
[    0.194253]   node   0: [mem 0x000000006c9a8000-0x000000006e6fffff]
[    0.194254]   node   0: [mem 0x0000000100000000-0x000000107fffffff]
[    0.194258] Initmem setup node 0 [mem 0x0000000000001000-0x000000107fffffff]
[    0.194261] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.194263] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.194283] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.196467] On node 0, zone DMA32: 40729 pages in unavailable ranges
[    0.272303] On node 0, zone Normal: 6400 pages in unavailable ranges
[    0.272414] ACPI: PM-Timer IO Port: 0x1808
[    0.272422] ACPI: X2APIC_NMI (uid[0xffffffff] high level lint[0x1])
[    0.272424] ACPI: LAPIC_NMI (acpi_id[0xff] high level lint[0x1])
[    0.272453] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
[    0.272458] IOAPIC[1]: apic_id 9, version 32, address 0xfec01000, GSI 24-31
[    0.272463] IOAPIC[2]: apic_id 10, version 32, address 0xfec08000, GSI 32-39
[    0.272467] IOAPIC[3]: apic_id 11, version 32, address 0xfec10000, GSI 40-47
[    0.272471] IOAPIC[4]: apic_id 12, version 32, address 0xfec18000, GSI 48-55
[    0.272474] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.272475] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.272480] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.272482] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.272485] TSC deadline timer available
[    0.272486] smpboot: Allowing 12 CPUs, 0 hotplug CPUs
[    0.272510] [mem 0x90000000-0xfcffffff] available for PCI devices
[    0.272513] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.275727] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:12 nr_node_ids:1
[    0.276015] percpu: Embedded 55 pages/cpu s187744 r8192 d29344 u262144
[    0.276021] pcpu-alloc: s187744 r8192 d29344 u262144 alloc=1*2097152
[    0.276023] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 -- -- -- -- 
[    0.276055] Built 1 zonelists, mobility grouping on.  Total pages: 16403655
[    0.276063] Kernel command line: BOOT_IMAGE=/vmlinuz-5.19.0-rc8-test-00003-ge3a8d97e6a35 root=/dev/mapper/budai--vg-root ro consoleblank=600 quiet
[    0.276122] Unknown kernel command line parameters "BOOT_IMAGE=/vmlinuz-5.19.0-rc8-test-00003-ge3a8d97e6a35", will be passed to user space.
[    0.279040] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes, linear)
[    0.280503] Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
[    0.280599] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.280600] Stack Depot early init allocating hash table with memblock_alloc, 8388608 bytes
[    0.674510] Memory: 65128856K/66657812K available (12295K kernel code, 3277K rwdata, 3732K rodata, 1600K init, 14120K bss, 1528696K reserved, 0K cma-reserved)
[    0.674513] **********************************************************
[    0.674514] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
[    0.674514] **                                                      **
[    0.674515] ** This system shows unhashed kernel memory addresses   **
[    0.674515] ** via the console, logs, and other interfaces. This    **
[    0.674516] ** might reduce the security of your system.            **
[    0.674517] **                                                      **
[    0.674517] ** If you see this message and you are not debugging    **
[    0.674518] ** the kernel, report this immediately to your system   **
[    0.674518] ** administrator!                                       **
[    0.674519] **                                                      **
[    0.674519] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
[    0.674520] **********************************************************
[    0.675102] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=12, Nodes=1
[    0.675135] Kernel/User page tables isolation: enabled
[    0.675384] ftrace: allocating 35586 entries in 140 pages
[    0.681271] ftrace: allocated 140 pages with 3 groups
[    0.682664] Dynamic Preempt: voluntary
[    0.682867] Running RCU self tests
[    0.682876] rcu: Preemptible hierarchical RCU implementation.
[    0.682876] rcu: 	RCU lockdep checking is enabled.
[    0.682877] rcu: 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=12.
[    0.682878] 	Trampoline variant of Tasks RCU enabled.
[    0.682879] 	Rude variant of Tasks RCU enabled.
[    0.682880] 	Tracing variant of Tasks RCU enabled.
[    0.682880] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.682881] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=12
[    0.694108] NR_IRQS: 4352, nr_irqs: 1064, preallocated irqs: 16
[    0.694404] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.694526] random: crng init done
[    0.694636] Console: colour dummy device 80x25
[    0.694668] printk: console [tty0] enabled
[    0.694671] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.694672] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.694673] ... MAX_LOCK_DEPTH:          48
[    0.694674] ... MAX_LOCKDEP_KEYS:        8192
[    0.694675] ... CLASSHASH_SIZE:          4096
[    0.694676] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.694676] ... MAX_LOCKDEP_CHAINS:      65536
[    0.694677] ... CHAINHASH_SIZE:          32768
[    0.694678]  memory used by lock dependency info: 6365 kB
[    0.694679]  memory used for stack traces: 4224 kB
[    0.694680]  per task-struct memory footprint: 1920 bytes
[    0.694693] ACPI: Core revision 20220331
[    0.696202] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
[    0.696324] APIC: Switch to symmetric I/O mode setup
[    0.696609] x2apic: IRQ remapping doesn't support X2APIC mode
[    0.696681] Switched APIC routing to physical flat.
[    0.698015] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.716231] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x6aa99074b1c, max_idle_ns: 881590506587 ns
[    0.716245] Calibrating delay loop (skipped), value calculated using timer frequency.. 7399.70 BogoMIPS (lpj=14799400)
[    0.716248] pid_max: default: 32768 minimum: 301
[    0.733242] LSM: Security Framework initializing
[    0.733269] Yama: becoming mindful.
[    0.733430] AppArmor: AppArmor initialized
[    0.733636] Mount-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.733720] Mountpoint-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.734821] CPU0: Thermal monitoring enabled (TM1)
[    0.734913] process: using mwait in idle threads
[    0.734915] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.734917] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.734925] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.734927] Spectre V2 : Mitigation: IBRS
[    0.734928] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.734929] RETBleed: Mitigation: IBRS
[    0.734931] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.734932] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.734948] MDS: Mitigation: Clear CPU buffers
[    0.734949] TAA: Mitigation: Clear CPU buffers
[    0.734949] MMIO Stale Data: Mitigation: Clear CPU buffers
[    0.747944] debug: unmapping init [mem 0xffffffffbaa2e000-0xffffffffbaa35fff]
[    0.748520] smpboot: CPU0: Intel(R) Xeon(R) W-2135 CPU @ 3.70GHz (family: 0x6, model: 0x55, stepping: 0x4)
[    0.749364] cblist_init_generic: Setting adjustable number of callback queues.
[    0.749380] cblist_init_generic: Setting shift to 4 and lim to 1.
[    0.749478] cblist_init_generic: Setting shift to 4 and lim to 1.
[    0.749570] cblist_init_generic: Setting shift to 4 and lim to 1.
[    0.749654] Running RCU-tasks wait API self tests
[    0.852469] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.852601] ... version:                4
[    0.852603] ... bit width:              48
[    0.852605] ... generic registers:      4
[    0.852606] ... value mask:             0000ffffffffffff
[    0.852608] ... max period:             00007fffffffffff
[    0.852609] ... fixed-purpose events:   3
[    0.852611] ... event mask:             000000070000000f
[    0.852875] Estimated ratio of average max frequency by base frequency (times 1024): 1217
[    0.853014] rcu: Hierarchical SRCU implementation.
[    0.853015] rcu: 	Max phase no-delay instances is 1000.
[    0.855147] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.855959] smp: Bringing up secondary CPUs ...
[    0.856688] x86: Booting SMP configuration:
[    0.856693] .... node  #0, CPUs:        #1  #2  #3
[    0.870268] Callback from call_rcu_tasks_trace() invoked.
[    0.870268]   #4  #5  #6
[    0.880500] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[    0.880500] TAA CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/tsx_async_abort.html for more details.
[    0.880500] MMIO Stale Data CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/processor_mmio_stale_data.html for more details.
[    0.880909]   #7  #8  #9 #10 #11
[    0.888406] smp: Brought up 1 node, 12 CPUs
[    0.888406] smpboot: Max logical packages: 1
[    0.888406] smpboot: Total of 12 processors activated (88796.40 BogoMIPS)
[    0.898028] devtmpfs: initialized
[    0.903767] DMA-API: preallocated 65536 debug entries
[    0.903771] DMA-API: debugging enabled by kernel config
[    0.903774] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.903786] futex hash table entries: 4096 (order: 7, 524288 bytes, linear)
[    0.904810] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.905930] audit: initializing netlink subsys (disabled)
[    0.905975] audit: type=2000 audit(1658734470.212:1): state=initialized audit_enabled=0 res=1
[    0.905975] thermal_sys: Registered thermal governor 'fair_share'
[    0.905975] thermal_sys: Registered thermal governor 'step_wise'
[    0.905975] thermal_sys: Registered thermal governor 'user_space'
[    0.905975] thermal_sys: Registered thermal governor 'power_allocator'
[    0.905975] cpuidle: using governor menu
[    0.905975] Detected 1 PCC Subspaces
[    0.905975] Registering PCC driver as Mailbox controller
[    0.905975] HugeTLB: can optimize 4095 vmemmap pages for hugepages-1048576kB
[    0.905975] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.905975] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
[    0.905975] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
[    0.905975] pmd_set_huge: Cannot satisfy [mem 0x80000000-0x80200000] with a huge-page mapping due to MTRR override.
[    0.905975] PCI: Using configuration type 1 for base access
[    0.909880] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.927108] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.927129] HugeTLB: can optimize 7 vmemmap pages for hugepages-2048kB
[    0.927129] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.927129] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.928547] cryptd: max_cpu_qlen set to 1000
[    0.928740] ACPI: Added _OSI(Module Device)
[    0.928743] ACPI: Added _OSI(Processor Device)
[    0.928746] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.928748] ACPI: Added _OSI(Processor Aggregator Device)
[    0.928758] ACPI: Added _OSI(Linux-Dell-Video)
[    0.928766] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.928774] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.956903] Callback from call_rcu_tasks_rude() invoked.
[    1.639894] ACPI: 4 ACPI AML tables successfully acquired and loaded
[    1.794837] ACPI: Dynamic OEM Table Load:
[    1.951626] ACPI: Dynamic OEM Table Load:
[    2.126419] ACPI: Dynamic OEM Table Load:
[    3.004573] ACPI: Interpreter enabled
[    3.004632] ACPI: PM: (supports S0 S5)
[    3.004641] ACPI: Using IOAPIC for interrupt routing
[    3.005237] HEST: Table parsing has been initialized.
[    3.007163] GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.
[    3.007167] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    3.007169] PCI: Using E820 reservations for host bridge windows
[    3.069726] ACPI: Enabled 8 GPEs in block 00 to 7F
[    3.570026] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-15])
[    3.570053] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    3.571652] acpi PNP0A08:00: _OSC: platform does not support [AER LTR]
[    3.574618] acpi PNP0A08:00: _OSC: OS now controls [PME PCIeCapability]
[    3.574621] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    3.578025] acpi PNP0A08:00: host bridge window expanded to [mem 0xfd000000-0xfe7fffff window]; [mem 0xfd000000-0xfe7fffff window] ignored
[    3.580936] PCI host bridge to bus 0000:00
[    3.580942] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    3.580949] pci_bus 0000:00: root bus resource [io  0x1000-0x3fff window]
[    3.580954] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7fff window]
[    3.580960] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
[    3.580965] pci_bus 0000:00: root bus resource [mem 0x90000000-0xa33fffff window]
[    3.580971] pci_bus 0000:00: root bus resource [mem 0x40000000000-0x43fffffffff window]
[    3.580977] pci_bus 0000:00: root bus resource [bus 00-15]
[    3.581138] pci 0000:00:00.0: [8086:2020] type 00 class 0x060000
[    3.581983] pci 0000:00:04.0: [8086:2021] type 00 class 0x088000
[    3.582004] pci 0000:00:04.0: reg 0x10: [mem 0x43ffff2c000-0x43ffff2ffff 64bit]
[    3.582666] pci 0000:00:04.1: [8086:2021] type 00 class 0x088000
[    3.582686] pci 0000:00:04.1: reg 0x10: [mem 0x43ffff28000-0x43ffff2bfff 64bit]
[    3.583378] pci 0000:00:04.2: [8086:2021] type 00 class 0x088000
[    3.583398] pci 0000:00:04.2: reg 0x10: [mem 0x43ffff24000-0x43ffff27fff 64bit]
[    3.584070] pci 0000:00:04.3: [8086:2021] type 00 class 0x088000
[    3.584090] pci 0000:00:04.3: reg 0x10: [mem 0x43ffff20000-0x43ffff23fff 64bit]
[    3.584745] pci 0000:00:04.4: [8086:2021] type 00 class 0x088000
[    3.584765] pci 0000:00:04.4: reg 0x10: [mem 0x43ffff1c000-0x43ffff1ffff 64bit]
[    3.585443] pci 0000:00:04.5: [8086:2021] type 00 class 0x088000
[    3.585463] pci 0000:00:04.5: reg 0x10: [mem 0x43ffff18000-0x43ffff1bfff 64bit]
[    3.586126] pci 0000:00:04.6: [8086:2021] type 00 class 0x088000
[    3.586146] pci 0000:00:04.6: reg 0x10: [mem 0x43ffff14000-0x43ffff17fff 64bit]
[    3.586813] pci 0000:00:04.7: [8086:2021] type 00 class 0x088000
[    3.586833] pci 0000:00:04.7: reg 0x10: [mem 0x43ffff10000-0x43ffff13fff 64bit]
[    3.587498] pci 0000:00:05.0: [8086:2024] type 00 class 0x088000
[    3.588170] pci 0000:00:05.2: [8086:2025] type 00 class 0x088000
[    3.588519] pci 0000:00:05.4: [8086:2026] type 00 class 0x080020
[    3.588537] pci 0000:00:05.4: reg 0x10: [mem 0xa3324000-0xa3324fff]
[    3.588906] pci 0000:00:08.0: [8086:2014] type 00 class 0x088000
[    3.589557] pci 0000:00:08.1: [8086:2015] type 00 class 0x110100
[    3.589856] pci 0000:00:08.2: [8086:2016] type 00 class 0x088000
[    3.590221] pci 0000:00:14.0: [8086:a2af] type 00 class 0x0c0330
[    3.590252] pci 0000:00:14.0: reg 0x10: [mem 0x43ffff00000-0x43ffff0ffff 64bit]
[    3.590378] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    3.593485] pci 0000:00:14.2: [8086:a2b1] type 00 class 0x118000
[    3.593516] pci 0000:00:14.2: reg 0x10: [mem 0x43ffff33000-0x43ffff33fff 64bit]
[    3.594219] pci 0000:00:16.0: [8086:a2ba] type 00 class 0x078000
[    3.594250] pci 0000:00:16.0: reg 0x10: [mem 0x43ffff32000-0x43ffff32fff 64bit]
[    3.594370] pci 0000:00:16.0: PME# supported from D3hot
[    3.594977] pci 0000:00:1d.0: [8086:a298] type 01 class 0x060400
[    3.595111] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    3.601892] pci 0000:00:1d.2: [8086:a29a] type 01 class 0x060400
[    3.602032] pci 0000:00:1d.2: PME# supported from D0 D3hot D3cold
[    3.608943] pci 0000:00:1e.0: [8086:a2a7] type 00 class 0x118000
[    3.609152] pci 0000:00:1e.0: reg 0x10: [mem 0x43ffff31000-0x43ffff31fff 64bit]
[    3.612199] pci 0000:00:1f.0: [8086:a2d3] type 00 class 0x060100
[    3.614707] pci 0000:00:1f.2: [8086:a2a1] type 00 class 0x058000
[    3.614727] pci 0000:00:1f.2: reg 0x10: [mem 0xa3320000-0xa3323fff]
[    3.617240] pci 0000:00:1f.4: [8086:a2a3] type 00 class 0x0c0500
[    3.617299] pci 0000:00:1f.4: reg 0x10: [mem 0x43ffff30000-0x43ffff300ff 64bit]
[    3.617372] pci 0000:00:1f.4: reg 0x20: [io  0x3000-0x301f]
[    3.618036] pci 0000:00:1f.6: [8086:15b7] type 00 class 0x020000
[    3.618066] pci 0000:00:1f.6: reg 0x10: [mem 0xa3300000-0xa331ffff]
[    3.618244] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
[    3.620825] pci 0000:00:1d.0: PCI bridge to [bus 01]
[    3.621099] pci 0000:02:00.0: [12d8:e113] type 01 class 0x060400
[    3.621183] pci 0000:02:00.0: enabling Extended Tags
[    3.621331] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    3.622040] pci 0000:00:1d.2: PCI bridge to [bus 02-03]
[    3.622099] pci_bus 0000:03: extended config space not accessible
[    3.622285] pci 0000:02:00.0: PCI bridge to [bus 03]
[    3.622330] pci_bus 0000:00: on NUMA node 0
[    3.634450] ACPI: PCI Root Bridge [PC01] (domain 0000 [bus 16-63])
[    3.634468] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    3.636259] acpi PNP0A08:01: _OSC: platform does not support [AER LTR]
[    3.639640] acpi PNP0A08:01: _OSC: OS now controls [PME PCIeCapability]
[    3.639642] acpi PNP0A08:01: FADT indicates ASPM is unsupported, using BIOS configuration
[    3.644870] PCI host bridge to bus 0000:16
[    3.644877] pci_bus 0000:16: root bus resource [io  0x4000-0x7fff window]
[    3.644883] pci_bus 0000:16: root bus resource [mem 0xa3400000-0xbe3fffff window]
[    3.644888] pci_bus 0000:16: root bus resource [mem 0x44000000000-0x47fffffffff window]
[    3.644891] pci_bus 0000:16: root bus resource [bus 16-63]
[    3.644989] pci 0000:16:02.0: [8086:2032] type 01 class 0x060400
[    3.645038] pci 0000:16:02.0: enabling Extended Tags
[    3.645125] pci 0000:16:02.0: PME# supported from D0 D3hot D3cold
[    3.645784] pci 0000:16:05.0: [8086:2034] type 00 class 0x088000
[    3.646136] pci 0000:16:05.2: [8086:2035] type 00 class 0x088000
[    3.646482] pci 0000:16:05.4: [8086:2036] type 00 class 0x080020
[    3.646500] pci 0000:16:05.4: reg 0x10: [mem 0xbe300000-0xbe300fff]
[    3.646861] pci 0000:16:08.0: [8086:208d] type 00 class 0x088000
[    3.647468] pci 0000:16:08.1: [8086:208d] type 00 class 0x088000
[    3.647758] pci 0000:16:08.2: [8086:208d] type 00 class 0x088000
[    3.648046] pci 0000:16:08.3: [8086:208d] type 00 class 0x088000
[    3.648336] pci 0000:16:08.4: [8086:208d] type 00 class 0x088000
[    3.648624] pci 0000:16:08.5: [8086:208d] type 00 class 0x088000
[    3.648915] pci 0000:16:08.6: [8086:208d] type 00 class 0x088000
[    3.649203] pci 0000:16:08.7: [8086:208d] type 00 class 0x088000
[    3.649504] pci 0000:16:09.0: [8086:208d] type 00 class 0x088000
[    3.650109] pci 0000:16:09.1: [8086:208d] type 00 class 0x088000
[    3.650410] pci 0000:16:0e.0: [8086:208e] type 00 class 0x088000
[    3.651007] pci 0000:16:0e.1: [8086:208e] type 00 class 0x088000
[    3.651299] pci 0000:16:0e.2: [8086:208e] type 00 class 0x088000
[    3.651582] pci 0000:16:0e.3: [8086:208e] type 00 class 0x088000
[    3.651872] pci 0000:16:0e.4: [8086:208e] type 00 class 0x088000
[    3.652159] pci 0000:16:0e.5: [8086:208e] type 00 class 0x088000
[    3.652451] pci 0000:16:0e.6: [8086:208e] type 00 class 0x088000
[    3.652737] pci 0000:16:0e.7: [8086:208e] type 00 class 0x088000
[    3.653026] pci 0000:16:0f.0: [8086:208e] type 00 class 0x088000
[    3.653638] pci 0000:16:0f.1: [8086:208e] type 00 class 0x088000
[    3.653946] pci 0000:16:1d.0: [8086:2054] type 00 class 0x088000
[    3.654546] pci 0000:16:1d.1: [8086:2055] type 00 class 0x088000
[    3.654835] pci 0000:16:1d.2: [8086:2056] type 00 class 0x088000
[    3.655122] pci 0000:16:1d.3: [8086:2057] type 00 class 0x088000
[    3.655413] pci 0000:16:1e.0: [8086:2080] type 00 class 0x088000
[    3.656023] pci 0000:16:1e.1: [8086:2081] type 00 class 0x088000
[    3.656314] pci 0000:16:1e.2: [8086:2082] type 00 class 0x088000
[    3.656604] pci 0000:16:1e.3: [8086:2083] type 00 class 0x088000
[    3.656897] pci 0000:16:1e.4: [8086:2084] type 00 class 0x088000
[    3.657186] pci 0000:16:1e.5: [8086:2085] type 00 class 0x088000
[    3.657478] pci 0000:16:1e.6: [8086:2086] type 00 class 0x088000
[    3.658060] pci 0000:17:00.0: [144d:a808] type 00 class 0x010802
[    3.658089] pci 0000:17:00.0: reg 0x10: [mem 0xbe200000-0xbe203fff 64bit]
[    3.658949] pci 0000:16:02.0: PCI bridge to [bus 17]
[    3.658954] pci 0000:16:02.0:   bridge window [mem 0xbe200000-0xbe2fffff]
[    3.658971] pci_bus 0000:16: on NUMA node 0
[    3.660567] ACPI: PCI Root Bridge [PC02] (domain 0000 [bus 64-b1])
[    3.660584] acpi PNP0A08:02: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    3.662395] acpi PNP0A08:02: _OSC: platform does not support [AER LTR]
[    3.665795] acpi PNP0A08:02: _OSC: OS now controls [PME PCIeCapability]
[    3.665798] acpi PNP0A08:02: FADT indicates ASPM is unsupported, using BIOS configuration
[    3.670594] PCI host bridge to bus 0000:64
[    3.670600] pci_bus 0000:64: root bus resource [mem 0x000a0000-0x000bffff window]
[    3.670606] pci_bus 0000:64: root bus resource [io  0x8000-0xbfff window]
[    3.670611] pci_bus 0000:64: root bus resource [io  0x03b0-0x03bb window]
[    3.670617] pci_bus 0000:64: root bus resource [io  0x03c0-0x03df window]
[    3.670625] pci_bus 0000:64: root bus resource [mem 0xbe400000-0xe0ffffff window]
[    3.670631] pci_bus 0000:64: root bus resource [mem 0x48000000000-0x4bfffffffff window]
[    3.670634] pci_bus 0000:64: root bus resource [bus 64-b1]
[    3.670724] pci 0000:64:00.0: [8086:2030] type 01 class 0x060400
[    3.670852] pci 0000:64:00.0: PME# supported from D0 D3hot D3cold
[    3.671509] pci 0000:64:05.0: [8086:2034] type 00 class 0x088000
[    3.671859] pci 0000:64:05.2: [8086:2035] type 00 class 0x088000
[    3.672203] pci 0000:64:05.4: [8086:2036] type 00 class 0x080020
[    3.672221] pci 0000:64:05.4: reg 0x10: [mem 0xe0100000-0xe0100fff]
[    3.672586] pci 0000:64:08.0: [8086:2066] type 00 class 0x088000
[    3.673250] pci 0000:64:09.0: [8086:2066] type 00 class 0x088000
[    3.673907] pci 0000:64:0a.0: [8086:2040] type 00 class 0x088000
[    3.674560] pci 0000:64:0a.1: [8086:2041] type 00 class 0x088000
[    3.674898] pci 0000:64:0a.2: [8086:2042] type 00 class 0x088000
[    3.675227] pci 0000:64:0a.3: [8086:2043] type 00 class 0x088000
[    3.675561] pci 0000:64:0a.4: [8086:2044] type 00 class 0x088000
[    3.675899] pci 0000:64:0a.5: [8086:2045] type 00 class 0x088000
[    3.676231] pci 0000:64:0a.6: [8086:2046] type 00 class 0x088000
[    3.676562] pci 0000:64:0a.7: [8086:2047] type 00 class 0x088000
[    3.676894] pci 0000:64:0b.0: [8086:2048] type 00 class 0x088000
[    3.677548] pci 0000:64:0b.1: [8086:2049] type 00 class 0x088000
[    3.677889] pci 0000:64:0b.2: [8086:204a] type 00 class 0x088000
[    3.678218] pci 0000:64:0b.3: [8086:204b] type 00 class 0x088000
[    3.678557] pci 0000:64:0c.0: [8086:2040] type 00 class 0x088000
[    3.679201] pci 0000:64:0c.1: [8086:2041] type 00 class 0x088000
[    3.679537] pci 0000:64:0c.2: [8086:2042] type 00 class 0x088000
[    3.679874] pci 0000:64:0c.3: [8086:2043] type 00 class 0x088000
[    3.680207] pci 0000:64:0c.4: [8086:2044] type 00 class 0x088000
[    3.680539] pci 0000:64:0c.5: [8086:2045] type 00 class 0x088000
[    3.680874] pci 0000:64:0c.6: [8086:2046] type 00 class 0x088000
[    3.681215] pci 0000:64:0c.7: [8086:2047] type 00 class 0x088000
[    3.681555] pci 0000:64:0d.0: [8086:2048] type 00 class 0x088000
[    3.682197] pci 0000:64:0d.1: [8086:2049] type 00 class 0x088000
[    3.682536] pci 0000:64:0d.2: [8086:204a] type 00 class 0x088000
[    3.682866] pci 0000:64:0d.3: [8086:204b] type 00 class 0x088000
[    3.683510] pci 0000:65:00.0: [10de:1cb1] type 00 class 0x030000
[    3.683533] pci 0000:65:00.0: reg 0x10: [mem 0xdf000000-0xdfffffff]
[    3.683553] pci 0000:65:00.0: reg 0x14: [mem 0xc0000000-0xcfffffff 64bit pref]
[    3.683573] pci 0000:65:00.0: reg 0x1c: [mem 0xd0000000-0xd1ffffff 64bit pref]
[    3.683587] pci 0000:65:00.0: reg 0x24: [io  0xb000-0xb07f]
[    3.683601] pci 0000:65:00.0: reg 0x30: [mem 0xe0000000-0xe007ffff pref]
[    3.683689] pci 0000:65:00.0: BAR 1: assigned to efifb
[    3.683812] pci 0000:65:00.0: 32.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x16 link at 0000:64:00.0 (capable of 126.016 Gb/s with 8.0 GT/s PCIe x16 link)
[    3.684420] pci 0000:65:00.1: [10de:0fb9] type 00 class 0x040300
[    3.684439] pci 0000:65:00.1: reg 0x10: [mem 0xe0080000-0xe0083fff]
[    3.684914] pci 0000:64:00.0: PCI bridge to [bus 65]
[    3.684918] pci 0000:64:00.0:   bridge window [io  0xb000-0xbfff]
[    3.684922] pci 0000:64:00.0:   bridge window [mem 0xdf000000-0xe00fffff]
[    3.684926] pci 0000:64:00.0:   bridge window [mem 0xc0000000-0xd1ffffff 64bit pref]
[    3.684940] pci_bus 0000:64: on NUMA node 0
[    3.686316] ACPI: PCI Root Bridge [PC03] (domain 0000 [bus b2-ff])
[    3.686332] acpi PNP0A08:03: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    3.688137] acpi PNP0A08:03: _OSC: platform does not support [AER LTR]
[    3.691526] acpi PNP0A08:03: _OSC: OS now controls [PME PCIeCapability]
[    3.691528] acpi PNP0A08:03: FADT indicates ASPM is unsupported, using BIOS configuration
[    3.696303] PCI host bridge to bus 0000:b2
[    3.696310] pci_bus 0000:b2: root bus resource [io  0xc000-0xffff window]
[    3.696316] pci_bus 0000:b2: root bus resource [mem 0xe1000000-0xfbffffff window]
[    3.696321] pci_bus 0000:b2: root bus resource [mem 0x4c000000000-0x4ffffffffff window]
[    3.696324] pci_bus 0000:b2: root bus resource [bus b2-ff]
[    3.696416] pci 0000:b2:00.0: [8086:2030] type 01 class 0x060400
[    3.696467] pci 0000:b2:00.0: enabling Extended Tags
[    3.696552] pci 0000:b2:00.0: PME# supported from D0 D3hot D3cold
[    3.697209] pci 0000:b2:05.0: [8086:2034] type 00 class 0x088000
[    3.697564] pci 0000:b2:05.2: [8086:2035] type 00 class 0x088000
[    3.697907] pci 0000:b2:05.4: [8086:2036] type 00 class 0x080020
[    3.697925] pci 0000:b2:05.4: reg 0x10: [mem 0xfbf00000-0xfbf00fff]
[    3.698300] pci 0000:b2:12.0: [8086:204c] type 00 class 0x110100
[    3.698940] pci 0000:b2:12.1: [8086:204d] type 00 class 0x110100
[    3.699233] pci 0000:b2:12.2: [8086:204e] type 00 class 0x088000
[    3.699528] pci 0000:b2:15.0: [8086:2018] type 00 class 0x088000
[    3.700142] pci 0000:b2:16.0: [8086:2018] type 00 class 0x088000
[    3.700749] pci 0000:b2:16.4: [8086:2018] type 00 class 0x088000
[    3.701314] pci 0000:b2:00.0: PCI bridge to [bus b3]
[    3.701333] pci_bus 0000:b2: on NUMA node 0
[    3.703967] ACPI: PCI: Interrupt link LNKA configured for IRQ 11
[    3.704806] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    3.705619] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    3.706427] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    3.707234] ACPI: PCI: Interrupt link LNKE configured for IRQ 11
[    3.708040] ACPI: PCI: Interrupt link LNKF configured for IRQ 11
[    3.708849] ACPI: PCI: Interrupt link LNKG configured for IRQ 11
[    3.709659] ACPI: PCI: Interrupt link LNKH configured for IRQ 15
[    3.712367] iommu: Default domain type: Translated 
[    3.712369] iommu: DMA domain TLB invalidation policy: lazy mode 
[    3.713049] SCSI subsystem initialized
[    3.713147] libata version 3.00 loaded.
[    3.713346] ACPI: bus type USB registered
[    3.713526] usbcore: registered new interface driver usbfs
[    3.713614] usbcore: registered new interface driver hub
[    3.713681] usbcore: registered new device driver usb
[    3.713821] EDAC MC: Ver: 3.0.0
[    3.716473] Registered efivars operations
[    3.716473] PCI: Using ACPI for IRQ routing
[    3.722717] PCI: pci_cache_line_size set to 64 bytes
[    3.722899] e820: reserve RAM buffer [mem 0x0003f000-0x0003ffff]
[    3.722914] e820: reserve RAM buffer [mem 0x604e0000-0x63ffffff]
[    3.722920] e820: reserve RAM buffer [mem 0x62a8f000-0x63ffffff]
[    3.722926] e820: reserve RAM buffer [mem 0x6e700000-0x6fffffff]
[    3.725276] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    3.725291] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    3.729573] clocksource: Switched to clocksource tsc-early
[    3.730662] VFS: Disk quotas dquot_6.6.0
[    3.730718] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    3.732169] AppArmor: AppArmor Filesystem Enabled
[    3.732169] pnp: PnP ACPI init
[    3.783368] system 00:01: [io  0x0500-0x05fe] has been reserved
[    3.783387] system 00:01: [io  0x0400-0x047f] could not be reserved
[    3.783397] system 00:01: [io  0x0600-0x061f] has been reserved
[    3.783406] system 00:01: [io  0x0ca0-0x0ca5] has been reserved
[    3.783415] system 00:01: [io  0x0880-0x0883] has been reserved
[    3.783423] system 00:01: [io  0x0800-0x081f] has been reserved
[    3.783440] system 00:01: [mem 0xfed1c000-0xfed3ffff] could not be reserved
[    3.783466] system 00:01: [mem 0xfed45000-0xfed8bfff] has been reserved
[    3.783476] system 00:01: [mem 0xff000000-0xffffffff] has been reserved
[    3.783490] system 00:01: [mem 0xfee00000-0xfeefffff] could not be reserved
[    3.783500] system 00:01: [mem 0xfed12000-0xfed1200f] has been reserved
[    3.783510] system 00:01: [mem 0xfed12010-0xfed1201f] has been reserved
[    3.783519] system 00:01: [mem 0xfed1b000-0xfed1bfff] has been reserved
[    3.785913] system 00:02: [io  0x0a00-0x0a0f] has been reserved
[    3.785927] system 00:02: [io  0x0a10-0x0a1f] has been reserved
[    3.785936] system 00:02: [io  0x0a20-0x0a2f] has been reserved
[    3.789763] system 00:03: [io  0x0a20-0x0a2f] has been reserved
[    3.790576] system 00:04: [mem 0xfd000000-0xfdabffff] has been reserved
[    3.790587] system 00:04: [mem 0xfdad0000-0xfdadffff] has been reserved
[    3.790601] system 00:04: [mem 0xfdb00000-0xfdffffff] could not be reserved
[    3.790611] system 00:04: [mem 0xfe000000-0xfe00ffff] has been reserved
[    3.790621] system 00:04: [mem 0xfe011000-0xfe01ffff] has been reserved
[    3.790630] system 00:04: [mem 0xfe036000-0xfe03bfff] has been reserved
[    3.790640] system 00:04: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    3.790650] system 00:04: [mem 0xfe410000-0xfe7fffff] has been reserved
[    3.792356] system 00:05: [io  0x0f00-0x0ffe] has been reserved
[    3.792359] Callback from call_rcu_tasks() invoked.
[    3.804833] system 00:06: [mem 0xfdaf0000-0xfdafffff] has been reserved
[    3.804845] system 00:06: [mem 0xfdae0000-0xfdaeffff] has been reserved
[    3.804855] system 00:06: [mem 0xfdac0000-0xfdacffff] has been reserved
[    3.815354] pnp: PnP ACPI: found 7 devices
[    3.831021] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    3.831205] NET: Registered PF_INET protocol family
[    3.831487] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    3.834382] tcp_listen_portaddr_hash hash table entries: 32768 (order: 9, 2359296 bytes, linear)
[    3.835017] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    3.835141] TCP established hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    3.835545] TCP bind hash table entries: 65536 (order: 10, 4718592 bytes, vmalloc hugepage)
[    3.836824] TCP: Hash tables configured (established 524288 bind 65536)
[    3.837174] UDP hash table entries: 32768 (order: 10, 5242880 bytes, vmalloc hugepage)
[    3.838508] UDP-Lite hash table entries: 32768 (order: 10, 5242880 bytes, vmalloc hugepage)
[    3.840096] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    3.840147] pci 0000:00:1d.0: bridge window [io  0x1000-0x0fff] to [bus 01] add_size 1000
[    3.840155] pci 0000:00:1d.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 01] add_size 200000 add_align 100000
[    3.840162] pci 0000:00:1d.0: bridge window [mem 0x00100000-0x000fffff] to [bus 01] add_size 200000 add_align 100000
[    3.840189] clipped [mem size 0x00004000] to [mem size 0xfffffffffffc8000] for e820 entry [mem 0x000a0000-0x000fffff]
[    3.840201] pci 0000:00:1d.0: BAR 14: assigned [mem 0x90000000-0x901fffff]
[    3.840205] clipped [mem size 0x00000000 64bit pref] to [mem size 0xfffffffffffc4000 64bit pref] for e820 entry [mem 0x000a0000-0x000fffff]
[    3.840210] pci 0000:00:1d.0: BAR 15: assigned [mem 0x40000000000-0x400001fffff 64bit pref]
[    3.840216] pci 0000:00:1d.0: BAR 13: assigned [io  0x1000-0x1fff]
[    3.840248] pci 0000:00:1d.0: PCI bridge to [bus 01]
[    3.840251] pci 0000:00:1d.0:   bridge window [io  0x1000-0x1fff]
[    3.840259] pci 0000:00:1d.0:   bridge window [mem 0x90000000-0x901fffff]
[    3.840265] pci 0000:00:1d.0:   bridge window [mem 0x40000000000-0x400001fffff 64bit pref]
[    3.840276] pci 0000:02:00.0: PCI bridge to [bus 03]
[    3.840302] pci 0000:00:1d.2: PCI bridge to [bus 02-03]
[    3.840323] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    3.840325] pci_bus 0000:00: resource 5 [io  0x1000-0x3fff window]
[    3.840327] pci_bus 0000:00: resource 6 [mem 0x000c4000-0x000c7fff window]
[    3.840329] pci_bus 0000:00: resource 7 [mem 0xfd000000-0xfe7fffff window]
[    3.840331] pci_bus 0000:00: resource 8 [mem 0x90000000-0xa33fffff window]
[    3.840333] pci_bus 0000:00: resource 9 [mem 0x40000000000-0x43fffffffff window]
[    3.840335] pci_bus 0000:01: resource 0 [io  0x1000-0x1fff]
[    3.840337] pci_bus 0000:01: resource 1 [mem 0x90000000-0x901fffff]
[    3.840339] pci_bus 0000:01: resource 2 [mem 0x40000000000-0x400001fffff 64bit pref]
[    3.841375] pci 0000:16:02.0: PCI bridge to [bus 17]
[    3.841383] pci 0000:16:02.0:   bridge window [mem 0xbe200000-0xbe2fffff]
[    3.841398] pci_bus 0000:16: resource 4 [io  0x4000-0x7fff window]
[    3.841400] pci_bus 0000:16: resource 5 [mem 0xa3400000-0xbe3fffff window]
[    3.841402] pci_bus 0000:16: resource 6 [mem 0x44000000000-0x47fffffffff window]
[    3.841404] pci_bus 0000:17: resource 1 [mem 0xbe200000-0xbe2fffff]
[    3.841655] pci 0000:64:00.0: PCI bridge to [bus 65]
[    3.841658] pci 0000:64:00.0:   bridge window [io  0xb000-0xbfff]
[    3.841665] pci 0000:64:00.0:   bridge window [mem 0xdf000000-0xe00fffff]
[    3.841671] pci 0000:64:00.0:   bridge window [mem 0xc0000000-0xd1ffffff 64bit pref]
[    3.841682] pci_bus 0000:64: resource 4 [mem 0x000a0000-0x000bffff window]
[    3.841684] pci_bus 0000:64: resource 5 [io  0x8000-0xbfff window]
[    3.841686] pci_bus 0000:64: resource 6 [io  0x03b0-0x03bb window]
[    3.841688] pci_bus 0000:64: resource 7 [io  0x03c0-0x03df window]
[    3.841690] pci_bus 0000:64: resource 8 [mem 0xbe400000-0xe0ffffff window]
[    3.841692] pci_bus 0000:64: resource 9 [mem 0x48000000000-0x4bfffffffff window]
[    3.841694] pci_bus 0000:65: resource 0 [io  0xb000-0xbfff]
[    3.841696] pci_bus 0000:65: resource 1 [mem 0xdf000000-0xe00fffff]
[    3.841698] pci_bus 0000:65: resource 2 [mem 0xc0000000-0xd1ffffff 64bit pref]
[    3.841880] pci 0000:b2:00.0: PCI bridge to [bus b3]
[    3.841899] pci_bus 0000:b2: resource 4 [io  0xc000-0xffff window]
[    3.841901] pci_bus 0000:b2: resource 5 [mem 0xe1000000-0xfbffffff window]
[    3.841903] pci_bus 0000:b2: resource 6 [mem 0x4c000000000-0x4ffffffffff window]
[    3.845645] pci 0000:16:05.0: disabled boot interrupts on device [8086:2034]
[    3.845709] pci 0000:17:00.0: CLS mismatch (64 != 32), using 64 bytes
[    3.845715] pci 0000:64:05.0: disabled boot interrupts on device [8086:2034]
[    3.846039] pci 0000:65:00.1: D0 power state depends on 0000:65:00.0
[    3.846068] pci 0000:b2:05.0: disabled boot interrupts on device [8086:2034]
[    3.846219] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    3.846221] software IO TLB: mapped [mem 0x000000005904d000-0x000000005d04d000] (64MB)
[    3.846703] Unpacking initramfs...
[    3.864401] RAPL PMU: API unit is 2^-32 Joules, 2 fixed counters, 655360 ms ovfl timer
[    3.864405] RAPL PMU: hw unit of domain package 2^-14 Joules
[    3.864407] RAPL PMU: hw unit of domain dram 2^-16 Joules
[    3.876379] workingset: timestamp_bits=46 max_order=24 bucket_order=0
[    3.908228] NET: Registered PF_ALG protocol family
[    3.908349] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    3.908558] io scheduler mq-deadline registered
[    3.908917] cryptomgr_test (104) used greatest stack depth: 14576 bytes left
[    3.912953] pcieport 0000:00:1d.0: PME: Signaling with IRQ 24
[    3.915186] pcieport 0000:00:1d.2: PME: Signaling with IRQ 25
[    3.917945] pcieport 0000:16:02.0: PME: Signaling with IRQ 27
[    3.919998] pcieport 0000:64:00.0: PME: Signaling with IRQ 29
[    3.921814] pcieport 0000:b2:00.0: PME: Signaling with IRQ 31
[    3.923560] Monitor-Mwait will be used to enter C-1 state
[    3.923585] Monitor-Mwait will be used to enter C-2 state
[    3.923599] ACPI: \_SB_.SCK0.CP00: Found 2 idle states
[    3.928506] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
[    3.928555] ACPI: button: Sleep Button [SLPB]
[    3.928964] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    3.928974] ACPI: button: Power Button [PWRF]
[    3.944003] ERST: Error Record Serialization Table (ERST) support is initialized.
[    3.944059] pstore: Registered erst as persistent store backend
[    3.946100] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    3.948521] AMD-Vi: AMD IOMMUv2 functionality not available on this system - This is not a bug.
[    3.956270] nvme nvme0: pci function 0000:17:00.0
[    3.958564] e1000e: Intel(R) PRO/1000 Network Driver
[    3.958566] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    3.960404] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    3.965082] nvme nvme0: Shutdown timeout set to 8 seconds
[    3.972253] ------------[ cut here ]------------

[    3.972255] =============================
[    3.972255] WARNING: suspicious RCU usage
[    3.972256] 5.19.0-rc8-test-00003-ge3a8d97e6a35 #1 Not tainted
[    3.972257] -----------------------------
[    3.972257] include/trace/events/lock.h:48 suspicious rcu_dereference_check() usage!
[    3.972258] 
               other info that might help us debug this:

[    3.972258] 
               rcu_scheduler_active = 2, debug_locks = 1
[    3.972259] RCU used illegally from extended quiescent state!
[    3.972260] no locks held by swapper/0/0.
[    3.972261] 
               stack backtrace:
[    3.972261] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0-rc8-test-00003-ge3a8d97e6a35 #1
[    3.972263] Hardware name: LENOVO 30BFS44D00/1036, BIOS S03KT51A 01/17/2022
[    3.972264] Call Trace:
[    3.972265]  <TASK>
[    3.972267]  dump_stack_lvl+0x44/0x5b
[    3.972273]  lock_acquire.cold.74+0x1f/0x24
[    3.972286]  _raw_spin_lock_irqsave+0x38/0x60
[    3.972290]  ? down_trylock+0xf/0x40
[    3.972296]  down_trylock+0xf/0x40
[    3.972298]  ? vprintk_emit+0x7b/0x2c0
[    3.972301]  __down_trylock_console_sem+0x23/0x90
[    3.972304]  console_trylock+0x13/0x70
[    3.972306]  vprintk_emit+0x7b/0x2c0
[    3.972314]  _printk+0x58/0x73
[    3.972324]  ? rcu_eqs_exit.constprop.87+0x54/0xa0
[    3.972325]  report_bug.cold.2+0xc/0x4c
[    3.972331]  handle_bug+0x3f/0x70
[    3.972335]  exc_invalid_op+0x13/0x60
[    3.972339]  asm_exc_invalid_op+0x16/0x20
[    3.972341] RIP: 0010:rcu_eqs_exit.constprop.87+0x54/0xa0
[    3.972343] Code: 12 ba 48 8b 83 40 01 00 00 48 85 c0 74 20 48 83 c0 01 48 89 83 40 01 00 00 5b c3 cc cc cc cc 65 8b 05 8c 48 63 46 85 c0 74 c2 <0f> 0b eb be e8 93 ff ff ff 48 83 bb 48 01 00 00 00 8b 83 50 01 00
[    3.972344] RSP: 0000:ffffffffba203e28 EFLAGS: 00010002
[    3.972346] RAX: 0000000000000001 RBX: ffffd358bfa07010 RCX: 0000000000000001
[    3.972347] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
[    3.972348] RBP: 0000000000000001 R08: ffffffffffc40c55 R09: 000000000002be80
[    3.972349] R10: 000004b18007d4f2 R11: ffff9f467802b7a4 R12: ffffffffba4a9d80
[    3.972349] R13: ffffffffba4a9d00 R14: 0000000000000001 R15: 0000000000000000
[    3.972367]  cpuidle_enter_state+0x2f4/0x4b0
[    3.972375]  cpuidle_enter+0x29/0x40
[    3.972378]  do_idle+0x1d8/0x210
[    3.972385]  cpu_startup_entry+0x19/0x20
[    3.972387]  rest_init+0x117/0x1a0
[    3.972390]  arch_call_rest_init+0xa/0x14
[    3.972394]  start_kernel+0x6d8/0x703
[    3.972402]  secondary_startup_64_no_verify+0xce/0xdb
[    3.972421]  </TASK>

[    3.972422] =============================
[    3.972422] WARNING: suspicious RCU usage
[    3.972422] 5.19.0-rc8-test-00003-ge3a8d97e6a35 #1 Not tainted
[    3.972423] -----------------------------
[    3.972423] include/trace/events/lock.h:74 suspicious rcu_dereference_check() usage!
[    3.972424] 
               other info that might help us debug this:

[    3.972424] 
               rcu_scheduler_active = 2, debug_locks = 1
[    3.972425] RCU used illegally from extended quiescent state!
[    3.972425] 1 lock held by swapper/0/0:
[    3.972426]  #0: ffffffffba420cd8 ((console_sem).lock){....}-{2:2}, at: down_trylock+0xf/0x40
[    3.972430] 
               stack backtrace:
[    3.972431] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0-rc8-test-00003-ge3a8d97e6a35 #1
[    3.972432] Hardware name: LENOVO 30BFS44D00/1036, BIOS S03KT51A 01/17/2022
[    3.972433] Call Trace:
[    3.972433]  <TASK>
[    3.972434]  dump_stack_lvl+0x44/0x5b
[    3.972438]  lock_release.cold.73+0x1f/0x24
[    3.972446]  _raw_spin_unlock_irqrestore+0x1b/0x60
[    3.972450]  down_trylock+0x25/0x40
[    3.972453]  ? vprintk_emit+0x7b/0x2c0
[    3.972454]  __down_trylock_console_sem+0x23/0x90
[    3.972457]  console_trylock+0x13/0x70
[    3.972460]  vprintk_emit+0x7b/0x2c0
[    3.972468]  _printk+0x58/0x73
[    3.972478]  ? rcu_eqs_exit.constprop.87+0x54/0xa0
[    3.972479]  report_bug.cold.2+0xc/0x4c
[    3.972485]  handle_bug+0x3f/0x70
[    3.972488]  exc_invalid_op+0x13/0x60
[    3.972492]  asm_exc_invalid_op+0x16/0x20
[    3.972493] RIP: 0010:rcu_eqs_exit.constprop.87+0x54/0xa0
[    3.972495] Code: 12 ba 48 8b 83 40 01 00 00 48 85 c0 74 20 48 83 c0 01 48 89 83 40 01 00 00 5b c3 cc cc cc cc 65 8b 05 8c 48 63 46 85 c0 74 c2 <0f> 0b eb be e8 93 ff ff ff 48 83 bb 48 01 00 00 00 8b 83 50 01 00
[    3.972496] RSP: 0000:ffffffffba203e28 EFLAGS: 00010002
[    3.972497] RAX: 0000000000000001 RBX: ffffd358bfa07010 RCX: 0000000000000001
[    3.972498] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
[    3.972499] RBP: 0000000000000001 R08: ffffffffffc40c55 R09: 000000000002be80
[    3.972499] R10: 000004b18007d4f2 R11: ffff9f467802b7a4 R12: ffffffffba4a9d80
[    3.972500] R13: ffffffffba4a9d00 R14: 0000000000000001 R15: 0000000000000000
[    3.972519]  cpuidle_enter_state+0x2f4/0x4b0
[    3.972526]  cpuidle_enter+0x29/0x40
[    3.972529]  do_idle+0x1d8/0x210
[    3.972536]  cpu_startup_entry+0x19/0x20
[    3.972538]  rest_init+0x117/0x1a0
[    3.972541]  arch_call_rest_init+0xa/0x14
[    3.972542]  start_kernel+0x6d8/0x703
[    3.972551]  secondary_startup_64_no_verify+0xce/0xdb
[    3.972569]  </TASK>
[    3.972577] WARNING: CPU: 0 PID: 0 at kernel/rcu/tree.c:864 rcu_eqs_exit.constprop.87+0x54/0xa0
[    3.972580] Modules linked in:
[    3.972582] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0-rc8-test-00003-ge3a8d97e6a35 #1
[    3.972584] Hardware name: LENOVO 30BFS44D00/1036, BIOS S03KT51A 01/17/2022
[    3.972585] RIP: 0010:rcu_eqs_exit.constprop.87+0x54/0xa0
[    3.972587] Code: 12 ba 48 8b 83 40 01 00 00 48 85 c0 74 20 48 83 c0 01 48 89 83 40 01 00 00 5b c3 cc cc cc cc 65 8b 05 8c 48 63 46 85 c0 74 c2 <0f> 0b eb be e8 93 ff ff ff 48 83 bb 48 01 00 00 00 8b 83 50 01 00
[    3.972588] RSP: 0000:ffffffffba203e28 EFLAGS: 00010002
[    3.972591] RAX: 0000000000000001 RBX: ffffd358bfa07010 RCX: 0000000000000001
[    3.972592] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
[    3.972593] RBP: 0000000000000001 R08: ffffffffffc40c55 R09: 000000000002be80
[    3.972595] R10: 000004b18007d4f2 R11: ffff9f467802b7a4 R12: ffffffffba4a9d80
[    3.972596] R13: ffffffffba4a9d00 R14: 0000000000000001 R15: 0000000000000000
[    3.972598] FS:  0000000000000000(0000) GS:ffff9f4678000000(0000) knlGS:0000000000000000
[    3.972599] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.972601] CR2: ffff9f46b81ff000 CR3: 0000000c6d212001 CR4: 00000000003706f0
[    3.972603] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    3.972604] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    3.972605] Call Trace:
[    3.972607]  <TASK>
[    3.972608]  cpuidle_enter_state+0x2f4/0x4b0
[    3.972616]  cpuidle_enter+0x29/0x40
[    3.972620]  do_idle+0x1d8/0x210
[    3.972627]  cpu_startup_entry+0x19/0x20
[    3.972630]  rest_init+0x117/0x1a0
[    3.972633]  arch_call_rest_init+0xa/0x14
[    3.972635]  start_kernel+0x6d8/0x703
[    3.972644]  secondary_startup_64_no_verify+0xce/0xdb
[    3.972662]  </TASK>
[    3.972663] irq event stamp: 196057
[    3.972664] hardirqs last  enabled at (196057): [<ffffffffb9a00d06>] asm_sysvec_apic_timer_interrupt+0x16/0x20
[    3.972667] hardirqs last disabled at (196055): [<ffffffffb9c003f4>] __do_softirq+0x3f4/0x49c
[    3.972669] softirqs last  enabled at (196056): [<ffffffffb9c00332>] __do_softirq+0x332/0x49c
[    3.972671] softirqs last disabled at (196045): [<ffffffffb90cb5df>] irq_exit_rcu+0xaf/0xf0
[    3.972674] ---[ end trace 0000000000000000 ]---

[    3.972676] =============================
[    3.972677] WARNING: suspicious RCU usage
[    3.972678] 5.19.0-rc8-test-00003-ge3a8d97e6a35 #1 Not tainted
[    3.972679] -----------------------------
[    3.972680] include/trace/events/error_report.h:71 suspicious rcu_dereference_check() usage!
[    3.972682] 
               other info that might help us debug this:

[    3.972683] 
               rcu_scheduler_active = 2, debug_locks = 1
[    3.972684] RCU used illegally from extended quiescent state!
[    3.972685] no locks held by swapper/0/0.
[    3.972686] 
               stack backtrace:
[    3.972687] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0-rc8-test-00003-ge3a8d97e6a35 #1
[    3.972689] Hardware name: LENOVO 30BFS44D00/1036, BIOS S03KT51A 01/17/2022
[    3.972690] Call Trace:
[    3.972691]  <TASK>
[    3.972693]  dump_stack_lvl+0x44/0x5b
[    3.972697]  __warn.cold.12+0x105/0x107
[    3.972700]  ? rcu_eqs_exit.constprop.87+0x54/0xa0
[    3.972705]  report_bug+0xc1/0x100
[    3.972713]  handle_bug+0x3f/0x70
[    3.972716]  exc_invalid_op+0x13/0x60
[    3.972721]  asm_exc_invalid_op+0x16/0x20
[    3.972722] RIP: 0010:rcu_eqs_exit.constprop.87+0x54/0xa0
[    3.972724] Code: 12 ba 48 8b 83 40 01 00 00 48 85 c0 74 20 48 83 c0 01 48 89 83 40 01 00 00 5b c3 cc cc cc cc 65 8b 05 8c 48 63 46 85 c0 74 c2 <0f> 0b eb be e8 93 ff ff ff 48 83 bb 48 01 00 00 00 8b 83 50 01 00
[    3.972726] RSP: 0000:ffffffffba203e28 EFLAGS: 00010002
[    3.972728] RAX: 0000000000000001 RBX: ffffd358bfa07010 RCX: 0000000000000001
[    3.972730] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
[    3.972731] RBP: 0000000000000001 R08: ffffffffffc40c55 R09: 000000000002be80
[    3.972732] R10: 000004b18007d4f2 R11: ffff9f467802b7a4 R12: ffffffffba4a9d80
[    3.972734] R13: ffffffffba4a9d00 R14: 0000000000000001 R15: 0000000000000000
[    3.972752]  cpuidle_enter_state+0x2f4/0x4b0
[    3.972759]  cpuidle_enter+0x29/0x40
[    3.972763]  do_idle+0x1d8/0x210
[    3.972770]  cpu_startup_entry+0x19/0x20
[    3.972773]  rest_init+0x117/0x1a0
[    3.972776]  arch_call_rest_init+0xa/0x14
[    3.972778]  start_kernel+0x6d8/0x703
[    3.972787]  secondary_startup_64_no_verify+0xce/0xdb
[    3.972805]  </TASK>
[    3.972807] ------------[ cut here ]------------
[    3.972808] WARNING: CPU: 0 PID: 0 at kernel/sched/clock.c:397 sched_clock_tick+0x2b/0x60
[    3.972811] Modules linked in:
[    3.972813] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.19.0-rc8-test-00003-ge3a8d97e6a35 #1
[    3.972815] Hardware name: LENOVO 30BFS44D00/1036, BIOS S03KT51A 01/17/2022
[    3.972817] RIP: 0010:sched_clock_tick+0x2b/0x60
[    3.972818] Code: eb 06 5b c3 cc cc cc cc 66 90 8b 05 fb 48 40 01 85 c0 74 18 65 8b 05 ec 10 ef 46 85 c0 75 0d 65 8b 05 35 0e ef 46 85 c0 74 02 <0f> 0b e8 fe cb 8b 00 48 c7 c3 40 d5 02 00 89 c0 48 03 1c c5 c0 98
[    3.972820] RSP: 0000:ffffffffba203e28 EFLAGS: 00010002
[    3.972823] RAX: 0000000000000001 RBX: ffffd358bfa07010 RCX: 0000000000000001
[    3.972824] RDX: 0000000000000000 RSI: ffffffffba08e941 RDI: ffffffffba09b733
[    3.972825] RBP: 0000000000000001 R08: ffffffffffc40c55 R09: 000000000002be80
[    3.972827] R10: 000004b18007d4f2 R11: ffff9f467802b7a4 R12: ffffffffba4a9d80
[    3.972829] R13: ffffffffba4a9d00 R14: 0000000000000001 R15: 0000000000000000
[    3.972830] FS:  0000000000000000(0000) GS:ffff9f4678000000(0000) knlGS:0000000000000000
[    3.972832] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.972834] CR2: ffff9f46b81ff000 CR3: 0000000c6d212001 CR4: 00000000003706f0
[    3.972835] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    3.972837] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    3.972838] Call Trace:
[    3.972839]  <TASK>
[    3.972841]  cpuidle_enter_state+0xb7/0x4b0
[    3.972849]  cpuidle_enter+0x29/0x40
[    3.972853]  do_idle+0x1d8/0x210
[    3.972860]  cpu_startup_entry+0x19/0x20
[    3.972862]  rest_init+0x117/0x1a0
[    3.972866]  arch_call_rest_init+0xa/0x14
[    3.972868]  start_kernel+0x6d8/0x703
[    3.972876]  secondary_startup_64_no_verify+0xce/0xdb
[    3.972893]  </TASK>
[    3.972895] irq event stamp: 196057
[    3.972896] hardirqs last  enabled at (196057): [<ffffffffb9a00d06>] asm_sysvec_apic_timer_interrupt+0x16/0x20
[    3.972898] hardirqs last disabled at (196055): [<ffffffffb9c003f4>] __do_softirq+0x3f4/0x49c
[    3.972900] softirqs last  enabled at (196056): [<ffffffffb9c00332>] __do_softirq+0x332/0x49c
[    3.972903] softirqs last disabled at (196045): [<ffffffffb90cb5df>] irq_exit_rcu+0xaf/0xf0
[    3.972905] ---[ end trace 0000000000000000 ]---
[    3.978985] nvme nvme0: 12/0/0 default/read/poll queues
[    3.991754]  nvme0n1: p1 p2 p3
[    4.042581] debug: unmapping init [mem 0xffff9f367629b000-0xffff9f3677144fff]
[    4.104839] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) a4:ae:11:14:fc:bd
[    4.104844] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connection
[    4.104949] e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA No: FFFFFF-0FF
[    4.105276] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    4.105278] ehci-pci: EHCI PCI platform driver
[    4.107288] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    4.107396] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    4.108843] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000000009810
[    4.110564] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    4.110587] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    4.110599] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    4.111029] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.19
[    4.111035] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.111038] usb usb1: Product: xHCI Host Controller
[    4.111040] usb usb1: Manufacturer: Linux 5.19.0-rc8-test-00003-ge3a8d97e6a35 xhci-hcd
[    4.111042] usb usb1: SerialNumber: 0000:00:14.0
[    4.112211] hub 1-0:1.0: USB hub found
[    4.112314] hub 1-0:1.0: 16 ports detected
[    4.161426] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.19
[    4.161430] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.161433] usb usb2: Product: xHCI Host Controller
[    4.161435] usb usb2: Manufacturer: Linux 5.19.0-rc8-test-00003-ge3a8d97e6a35 xhci-hcd
[    4.161437] usb usb2: SerialNumber: 0000:00:14.0
[    4.162266] hub 2-0:1.0: USB hub found
[    4.162323] hub 2-0:1.0: 10 ports detected
[    4.196355] mousedev: PS/2 mouse device common for all mice
[    4.196802] rtc_cmos 00:00: RTC can wake from S4
[    4.197938] rtc_cmos 00:00: registered as rtc0
[    4.198087] rtc_cmos 00:00: setting system clock to 2022-07-25T07:34:33 UTC (1658734473)
[    4.198237] rtc_cmos 00:00: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    4.200008] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    4.200105] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    4.241068] i2c i2c-0: 4/8 memory slots populated (from DMI)
[    4.241071] i2c i2c-0: Systems with more than 4 memory slots not supported yet, not instantiating SPD
[    4.245778] device-mapper: ioctl: 4.46.0-ioctl (2022-02-22) initialised: dm-devel@redhat.com
[    4.246751] EDAC MC0: Giving out device to module skx_edac controller Skylake Socket#0 IMC#0: DEV 0000:64:0a.0 (INTERRUPT)
[    4.247229] EDAC MC1: Giving out device to module skx_edac controller Skylake Socket#0 IMC#1: DEV 0000:64:0c.0 (INTERRUPT)
[    4.247235] intel_pstate: Intel P-state driver initializing
[    4.249932] intel_pstate: HWP enabled
[    4.254032] efifb: probing for efifb
[    4.254118] efifb: framebuffer at 0xc0000000, using 9600k, total 9600k
[    4.254121] efifb: mode is 1920x1200x32, linelength=8192, pages=1
[    4.254123] efifb: scrolling: redraw
[    4.254124] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    4.255002] Console: switching to colour frame buffer device 240x75
[    4.258668] fb0: EFI VGA frame buffer device
[    4.258716] EFI Variables Facility v0.08 2004-May-17
[    4.289201] pstore: ignoring unexpected backend 'efi'
[    4.289327] hid: raw HID events driver (C) Jiri Kosina
[    4.289510] usbcore: registered new interface driver usbhid
[    4.289512] usbhid: USB HID core driver
[    4.291432] NET: Registered PF_INET6 protocol family
[    4.294216] Segment Routing with IPv6
[    4.294266] In-situ OAM (IOAM) with IPv6
[    4.294333] NET: Registered PF_PACKET protocol family
[    4.304194] microcode: sig=0x50654, pf=0x2, revision=0x2006d05
[    4.304656] microcode: Microcode Update Driver: v2.2.
[    4.304664] IPI shorthand broadcast: enabled
[    4.304700] AVX2 version of gcm_enc/dec engaged.
[    4.304931] AES CTR mode by8 optimization enabled
[    4.307293] sched_clock: Marking stable (4309428437, -2264104)->(4313172469, -6008136)
[    4.312720] registered taskstats version 1
[    4.312823] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
[    4.416262] usb 1-11: new high-speed USB device number 2 using xhci_hcd
[    4.502031] page_owner is disabled
[    4.502486] AppArmor: AppArmor sha1 policy hashing enabled
[    4.517910] debug: unmapping init [mem 0xffffffffba89e000-0xffffffffbaa2dfff]
[    4.536485] Write protecting the kernel read-only data: 18432k
[    4.537232] debug: unmapping init [mem 0xffffffffb9c02000-0xffffffffb9dfffff]
[    4.537413] debug: unmapping init [mem 0xffffffffba1a5000-0xffffffffba1fffff]
[    4.572753] usb 1-11: New USB device found, idVendor=0424, idProduct=2514, bcdDevice= b.b3
[    4.572763] usb 1-11: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    4.578033] hub 1-11:1.0: USB hub found
[    4.578206] hub 1-11:1.0: 3 ports detected
[    4.708260] usb 1-13: new high-speed USB device number 3 using xhci_hcd
[    4.857347] usb 1-13: New USB device found, idVendor=0bda, idProduct=0129, bcdDevice=39.60
[    4.857352] usb 1-13: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    4.857355] usb 1-13: Product: USB2.0-CRW
[    4.857357] usb 1-13: Manufacturer: Generic
[    4.857360] usb 1-13: SerialNumber: 20100201396000000
[    4.884325] tsc: Refined TSC clocksource calibration: 3695.999 MHz
[    4.884344] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x6a8d2284b57, max_idle_ns: 881590451434 ns
[    5.062316] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    5.062319] x86/mm: Checking user space page tables
[    5.062338] usb 1-11.1: new high-speed USB device number 4 using xhci_hcd
[    5.062370] clocksource: Switched to clocksource tsc
[    5.062512] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    5.062523] Run /init as init process
[    5.062525]   with arguments:
[    5.062527]     /init
[    5.062528]   with environment:
[    5.062530]     HOME=/
[    5.062532]     TERM=linux
[    5.062533]     BOOT_IMAGE=/vmlinuz-5.19.0-rc8-test-00003-ge3a8d97e6a35
[    5.068518] mkdir (144) used greatest stack depth: 13688 bytes left
[    5.165152] usb 1-11.1: New USB device found, idVendor=0424, idProduct=2640, bcdDevice= 0.00
[    5.165164] usb 1-11.1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    5.167990] hub 1-11.1:1.0: USB hub found
[    5.168242] hub 1-11.1:1.0: 3 ports detected
[    5.200272] all_generic_ide (157) used greatest stack depth: 13672 bytes left
[    5.386694] setupcon (161) used greatest stack depth: 13640 bytes left
[    5.424678] systemd-udevd (166) used greatest stack depth: 13536 bytes left
[    5.460544] usb 1-11.1.1: new high-speed USB device number 5 using xhci_hcd
[    5.505409] udevadm (168) used greatest stack depth: 13384 bytes left
[    5.615936] usb 1-11.1.1: New USB device found, idVendor=0424, idProduct=4060, bcdDevice= 1.82
[    5.615950] usb 1-11.1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    5.615958] usb 1-11.1.1: Product: Ultra Fast Media Reader
[    5.615965] usb 1-11.1.1: Manufacturer: Generic
[    5.615972] usb 1-11.1.1: SerialNumber: 000000264001
[    5.633841] usb-storage 1-11.1.1:1.0: USB Mass Storage device detected
[    5.635351] scsi host0: usb-storage 1-11.1.1:1.0
[    5.637795] usbcore: registered new interface driver usb-storage
[    5.641102] usbcore: registered new interface driver uas
[    5.700534] usb 1-11.1.2: new low-speed USB device number 6 using xhci_hcd
[    5.809537] usb 1-11.1.2: New USB device found, idVendor=17ef, idProduct=6099, bcdDevice= 1.14
[    5.809550] usb 1-11.1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    5.809558] usb 1-11.1.2: Product: Lenovo Traditional USB Keyboard
[    5.809565] usb 1-11.1.2: Manufacturer: LiteOn
[    5.825535] input: LiteOn Lenovo Traditional USB Keyboard as /devices/pci0000:00/0000:00:14.0/usb1/1-11/1-11.1/1-11.1.2/1-11.1.2:1.0/0003:17EF:6099.0001/input/input2
[    5.891349] hid-generic 0003:17EF:6099.0001: input,hidraw0: USB HID v1.11 Keyboard [LiteOn Lenovo Traditional USB Keyboard] on usb-0000:00:14.0-11.1.2/input0
[    5.900145] input: LiteOn Lenovo Traditional USB Keyboard System Control as /devices/pci0000:00/0000:00:14.0/usb1/1-11/1-11.1/1-11.1.2/1-11.1.2:1.1/0003:17EF:6099.0002/input/input3
[    5.959333] input: LiteOn Lenovo Traditional USB Keyboard Consumer Control as /devices/pci0000:00/0000:00:14.0/usb1/1-11/1-11.1/1-11.1.2/1-11.1.2:1.1/0003:17EF:6099.0002/input/input4
[    5.961410] hid-generic 0003:17EF:6099.0002: input,hidraw1: USB HID v1.11 Device [LiteOn Lenovo Traditional USB Keyboard] on usb-0000:00:14.0-11.1.2/input1
[    6.001527] e1000e 0000:00:1f.6 eno1: renamed from eth0
[    6.052630] udev (165) used greatest stack depth: 13288 bytes left
[    6.155901] process '/usr/bin/ipconfig' started with executable stack
[    6.292529] lvm (220) used greatest stack depth: 13176 bytes left
[    6.653179] scsi 0:0:0:0: Direct-Access     Generic  Ultra HS-SD/MMC  1.82 PQ: 0 ANSI: 0
[    6.666794] sd 0:0:0:0: [sda] Media removed, stopped polling
[    6.676026] sd 0:0:0:0: [sda] Attached SCSI removable disk
[    9.499125] e1000e 0000:00:1f.6 eno1: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
[    9.499487] IPv6: ADDRCONF(NETDEV_CHANGE): eno1: link becomes ready
[   10.751097] readlink (290) used greatest stack depth: 12984 bytes left
[   10.828828] systemd-udevd (179) used greatest stack depth: 12408 bytes left
[   17.791051] EXT4-fs (dm-1): mounted filesystem with ordered data mode. Quota mode: none.
[   18.054819] e1000e 0000:00:1f.6 eno1: NIC Link is Down
[   18.713278] modprobe (841) used greatest stack depth: 12152 bytes left
[   18.729375] systemd[1]: systemd 241 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
[   18.731182] systemd[1]: Detected architecture x86-64.
[   18.766343] systemd[1]: Set hostname to <budai>.
[   19.099821] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[   19.100498] systemd[1]: Listening on Journal Socket (/dev/log).
[   19.100850] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[   19.106316] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[   19.106334] systemd[1]: Reached target Remote File Systems.
[   19.106347] systemd[1]: Reached target System Time Synchronized.
[   19.106829] systemd[1]: Listening on udev Control Socket.
[   19.222364] EXT4-fs (dm-1): re-mounted. Quota mode: none.
[   19.539657] systemd-journald[867]: Received request to flush runtime journal from PID 1
[   20.771373] Adding 62496764k swap on /dev/mapper/budai--vg-swap.  Priority:-2 extents:1 across:62496764k SS
[   20.909147] EXT4-fs (nvme0n1p2): mounting ext2 file system using the ext4 subsystem
[   20.915903] EXT4-fs (nvme0n1p2): mounted filesystem without journal. Quota mode: none.
[   20.915941] ext2 filesystem being mounted at /boot supports timestamps until 2038 (0x7fffffff)
[   20.997050] EXT4-fs (dm-3): mounted filesystem with ordered data mode. Quota mode: none.
[   21.197502] audit: type=1400 audit(1658734490.496:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/man" pid=1019 comm="apparmor_parser"
[   21.197554] audit: type=1400 audit(1658734490.496:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_filter" pid=1019 comm="apparmor_parser"
[   21.197596] audit: type=1400 audit(1658734490.496:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_groff" pid=1019 comm="apparmor_parser"
[   21.199362] audit: type=1400 audit(1658734490.496:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe" pid=1018 comm="apparmor_parser"
[   21.199412] audit: type=1400 audit(1658734490.496:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe//kmod" pid=1018 comm="apparmor_parser"
[   21.202827] audit: type=1400 audit(1658734490.500:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/chronyd" pid=1017 comm="apparmor_parser"
[   24.686989] e1000e 0000:00:1f.6 eno1: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
[   24.687075] IPv6: ADDRCONF(NETDEV_CHANGE): eno1: link becomes ready
[  323.629427] kworker/dying (22) used greatest stack depth: 10960 bytes left

--mP3DRpeJDSE+ciuQ--
