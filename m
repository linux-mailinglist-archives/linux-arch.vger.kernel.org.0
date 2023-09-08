Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AB579870D
	for <lists+linux-arch@lfdr.de>; Fri,  8 Sep 2023 14:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240785AbjIHMec (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Sep 2023 08:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbjIHMec (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Sep 2023 08:34:32 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250E01BF1
        for <linux-arch@vger.kernel.org>; Fri,  8 Sep 2023 05:34:26 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so1810726f8f.3
        for <linux-arch@vger.kernel.org>; Fri, 08 Sep 2023 05:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694176464; x=1694781264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlMlO8FealBj+/rrG/AUzU2UA5CdlNvzxR7wkSDN7Ow=;
        b=dCPfDOHm/dZ6DONMTGueqqAK0oCEBivWrSGuTUWg3efb5QkQJSTJfS6q9NCgH5KKKq
         PQVhbPN20O5ArsGyAOMDfTiij8wxwHBnE+SMP8cXz3Do6HQSU/Rj7yq0AHzw4OubIxCR
         SL4a+Wgeje6/2JsrXSJH3Jhd/nCw8EVTvVM4xABT34IyuiQ3iDQkkyABTIOrKEEAR3/K
         Gx1ONbt56uvFD8xZeMjlfBtQgvRYp8XIn0yicH5wgoeBonNlws64rScN0vb1KtAmDB4C
         xfVz3kwQxtJ/uR74tAOD+WTcSRP5lezbSFnPZVnKbG3l7oRa0cYcVhwXFAtSFp0tiEHX
         1jSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694176464; x=1694781264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlMlO8FealBj+/rrG/AUzU2UA5CdlNvzxR7wkSDN7Ow=;
        b=WAM0wbrxA3r33N0ywSovNtFZvTpq2NpDGFszlDNwSBtu2AnsS+HzBRz1F1Ct+BPyqq
         gEEX5O/Q2aDT3s6HiDm8O/PMgSzvPMPbc5KQwgx41XhyA8Af9mIUiGGFcTqWFZSZc+If
         m2EHdO7i4F1wZqChF7W90DNBvWfPxFjBQE+/I33bMwxxaGxYItiis9eyu5MqsZHkcg0/
         P6yf+ZU8DBIup54fdAYVcvRGvYM01xNFfxO1kiW3vKo0YtyfMjWMg7AZdawE+MLWNXgg
         TtT2MfNCHWBYwKOwexoe4z/yW/T+EaGcki6+rqTgCwQf1ptUo9fO/r3wr/3HtCcU+ilG
         dp/A==
X-Gm-Message-State: AOJu0YzBPvNTtOVV1mYR/ljBTvaWGatIKzAh4xpajqNE3n2ApwjmiM8l
        0aFIULGXArB750WpwqxVaxC/OdsbowiZ6N/pbpNhJQ==
X-Google-Smtp-Source: AGHT+IFouy2jXUNwy6DNVaskl+A4XjlMLTTSBWXz6mwTmjOEmm+0FPBkaPo/JXFsNJuqUEU9OtqmCQTG4i1XKpihnfo=
X-Received: by 2002:a05:6000:180b:b0:319:6caa:ada2 with SMTP id
 m11-20020a056000180b00b003196caaada2mr1742878wrh.47.1694176464379; Fri, 08
 Sep 2023 05:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230801085402.1168351-1-alexghiti@rivosinc.com>
 <20230801085402.1168351-5-alexghiti@rivosinc.com> <CA+V-a8t56xDqMTQfoKcsvPF8errkTMydaDz5V6nejLvVfJrW3g@mail.gmail.com>
 <CAHVXubiENHt36LrcSBoNU0rAMQ8EoT6tde9M8vLP3Hw2nwMm8g@mail.gmail.com>
 <CA+V-a8vJJFCKy3pCL2Qp1NogL-K5s9moGDbv3tTvx+z1FeKarw@mail.gmail.com>
 <CAHVXubhLB9Pw51C1ed1Youp9k0qTJKrokUAqf=Xnr+m3BoN5=g@mail.gmail.com>
 <CA+V-a8s0i=VMSbMa6WvOiZpqe_idAhq4cZ0inSdCNy39-rQeAg@mail.gmail.com>
 <CAHVXubjgjAwMOi0J5zZJkuX8RKwgfKp-_=tVTLDvKN=tBBdxNQ@mail.gmail.com>
 <CA+V-a8uxe=sT7oX4Dk4zppCbYzWdZgWt9Xh4m+pA2+3t8kfnjg@mail.gmail.com>
 <CAHVXubitpk9RxMPc9+ss0y=ZmpOrfv0ocP+UDQktR=TM+gy=KQ@mail.gmail.com> <CA+V-a8tGGR8q1Wv=dJJKLkbAsfmH8p8Fn9Ycns7+1LCSzxvpZA@mail.gmail.com>
In-Reply-To: <CA+V-a8tGGR8q1Wv=dJJKLkbAsfmH8p8Fn9Ycns7+1LCSzxvpZA@mail.gmail.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Fri, 8 Sep 2023 14:34:13 +0200
Message-ID: <CAHVXubia1=pSN_CJ8RaE=HXr7+2Fb2WSha+_N1GzsJGau7n9fg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] riscv: Improve flush_tlb_kernel_range()
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Prabhakar,

On Thu, Sep 7, 2023 at 12:50=E2=80=AFPM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> Hi Alexandre,
>
> On Thu, Sep 7, 2023 at 10:06=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosi=
nc.com> wrote:
> >
> > Hi Prabhakar,
> >
> > On Wed, Sep 6, 2023 at 3:55=E2=80=AFPM Lad, Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> > >
> > > Hi Alexandre,
> > >
> > > On Wed, Sep 6, 2023 at 1:43=E2=80=AFPM Alexandre Ghiti <alexghiti@riv=
osinc.com> wrote:
> > > >
> > > > On Wed, Sep 6, 2023 at 2:24=E2=80=AFPM Lad, Prabhakar
> > > > <prabhakar.csengg@gmail.com> wrote:
> > > > >
> > > > > Hi Alexandre,
> > > > >
> > > > > On Wed, Sep 6, 2023 at 1:18=E2=80=AFPM Alexandre Ghiti <alexghiti=
@rivosinc.com> wrote:
> > > > > >
> > > > > > On Wed, Sep 6, 2023 at 2:09=E2=80=AFPM Lad, Prabhakar
> > > > > > <prabhakar.csengg@gmail.com> wrote:
> > > > > > >
> > > > > > > Hi Alexandre,
> > > > > > >
> > > > > > > On Wed, Sep 6, 2023 at 1:01=E2=80=AFPM Alexandre Ghiti <alexg=
hiti@rivosinc.com> wrote:
> > > > > > > >
> > > > > > > > Hi Prabhakar,
> > > > > > > >
> > > > > > > > On Wed, Sep 6, 2023 at 1:49=E2=80=AFPM Lad, Prabhakar
> > > > > > > > <prabhakar.csengg@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > Hi Alexandre,
> > > > > > > > >
> > > > > > > > > On Tue, Aug 1, 2023 at 9:58=E2=80=AFAM Alexandre Ghiti <a=
lexghiti@rivosinc.com> wrote:
> > > > > > > > > >
> > > > > > > > > > This function used to simply flush the whole tlb of all=
 harts, be more
> > > > > > > > > > subtile and try to only flush the range.
> > > > > > > > > >
> > > > > > > > > > The problem is that we can only use PAGE_SIZE as stride=
 since we don't know
> > > > > > > > > > the size of the underlying mapping and then this functi=
on will be improved
> > > > > > > > > > only if the size of the region to flush is < threshold =
* PAGE_SIZE.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > > > > > > > > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > > > > > > > > > ---
> > > > > > > > > >  arch/riscv/include/asm/tlbflush.h | 11 +++++-----
> > > > > > > > > >  arch/riscv/mm/tlbflush.c          | 34 +++++++++++++++=
++++++++--------
> > > > > > > > > >  2 files changed, 31 insertions(+), 14 deletions(-)
> > > > > > > > > >
> > > > > > > > > After applying this patch, I am seeing module load issues=
 on RZ/Five
> > > > > > > > > (complete log [0]). I am testing defconfig + [1] (rz/five=
 related
> > > > > > > > > configs).
> > > > > > > > >
> > > > > > > > > Any pointers on what could be an issue here?
> > > > > > > >
> > > > > > > > Can you give me the exact version of the kernel you use? Th=
e trap
> > > > > > > > addresses are vmalloc addresses, and a fix for those landed=
 very late
> > > > > > > > in the release cycle.
> > > > > > > >
> > > > > > > I am using next-20230906, Ive pushed a branch [1] for you to =
have a look.
> > > > > > >
> > > > > > > [0] https://github.com/prabhakarlad/linux/tree/rzfive-debug
> > > > > >
> > > > > > Great, thanks, I had to get rid of this possibility :)
> > > > > >
> > > > > > As-is, I have no idea, can you try to "bisect" the problem? I m=
ean
> > > > > > which patch in the series leads to those traps?
> > > > > >
> > > > > Oops sorry for not mentioning earlier, this is the offending patc=
h
> > > > > which leads to the issues seen on rz/five.
> > > >
> > > > Ok, so at least I found the following problem, but I don't see how
> > > > that could fix your issue: can you give a try anyway? I keep lookin=
g
> > > > into this, thanks
> > > >
> > > > diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> > > > index df2a0838c3a1..b5692bc6c76a 100644
> > > > --- a/arch/riscv/mm/tlbflush.c
> > > > +++ b/arch/riscv/mm/tlbflush.c
> > > > @@ -239,7 +239,7 @@ void flush_tlb_range(struct vm_area_struct *vma=
,
> > > > unsigned long start,
> > > >
> > > >  void flush_tlb_kernel_range(unsigned long start, unsigned long end=
)
> > > >  {
> > > > -       __flush_tlb_range(NULL, start, end, PAGE_SIZE);
> > > > +       __flush_tlb_range(NULL, start, end - start, PAGE_SIZE);
> > > >  }
> > > >
> > > I am able to reproduce the issue with the above change too.
> >
> > I can't reproduce the problem on my Unmatched or Qemu, so it is not
> > easy to debug. But I took another look at your traces and something is
> > weird to me. In the following trace (and there is another one), the
> > trap is taken at 0xffffffff015ca034, which is the beginning of
> > rz_ssi_probe(): that's a page fault, so no translation was found (or
> > an invalid one is cached).
> >
> > [   16.586527] Unable to handle kernel paging request at virtual
> > address ffffffff015ca034
> > [   16.594750] Oops [#3]
> > ...
> > [   16.622000] epc : rz_ssi_probe+0x0/0x52a [snd_soc_rz_ssi]
> > ...
> > [   16.708697] status: 0000000200000120 badaddr: ffffffff015ca034
> > cause: 000000000000000c
> > [   16.716580] [<ffffffff015ca034>] rz_ssi_probe+0x0/0x52a
> > [snd_soc_rz_ssi]
> > ...
> >
> > But then here we are able to read the code at this same address:
> > [   16.821620] Code: 0109 6597 0000 8593 5f65 7097 7f34 80e7 7aa0 b7a9
> > (7139) f822
> >
> > So that looks like a "transient" error. Do you know if you uarch
> > caches invalid TLB entries? If you don't know, I have just written
> > some piece of code to determine if it does, let me know.
> >
> No I dont, can you please share the details so that I can pass on the
> information to you.
>
> > Do those errors always happen?
> >
> Yes they do.
>

I still can't reproduce those errors, I built different configs
including yours, insmod/rmmod a few modules but still can't reproduce
that. I'm having a hard time understanding how the correct mapping
magically appears in the trap handler. We finally removed this
patchset from 6.6...

You can give the following patch a try to determine if your uarch
caches invalid TLB entries, but honestly, I'm not sure if that would
help (but it will test my patch :)). The output can be seen in dmesg
"uarch caches invalid entries:".

If the trap addresses are constant, I would try to breakpoint on
flush_tlb_kernel_range() on those addresses and see what happens:
maybe that's an alignment issue or something else, maybe that's not
even called before the trap...etc. More info are welcome :)

Thanks!

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 80af436c04ac..8f863b251898 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -58,6 +58,8 @@ bool pgtable_l5_enabled =3D IS_ENABLED(CONFIG_64BIT)
&& !IS_ENABLED(CONFIG_XIP_KER
 EXPORT_SYMBOL(pgtable_l4_enabled);
 EXPORT_SYMBOL(pgtable_l5_enabled);

+bool tlb_caching_invalid_entries;
+
 phys_addr_t phys_ram_base __ro_after_init;
 EXPORT_SYMBOL(phys_ram_base);

@@ -752,6 +754,18 @@ static void __init disable_pgtable_l4(void)
        satp_mode =3D SATP_MODE_39;
 }

+static void __init enable_pgtable_l5(void)
+{
+       pgtable_l5_enabled =3D true;
+       satp_mode =3D SATP_MODE_57;
+}
+
+static void __init enable_pgtable_l4(void)
+{
+       pgtable_l4_enabled =3D true;
+       satp_mode =3D SATP_MODE_48;
+}
+
 static int __init print_no4lvl(char *p)
 {
        pr_info("Disabled 4-level and 5-level paging");
@@ -828,6 +842,113 @@ static __init void set_satp_mode(uintptr_t dtb_pa)
        memset(early_pud, 0, PAGE_SIZE);
        memset(early_pmd, 0, PAGE_SIZE);
 }
+
+/* Determine at runtime if the uarch caches invalid TLB entries */
+static __init void set_tlb_caching_invalid_entries(void)
+{
+#define NR_RETRIES_CACHING_INVALID_ENTRIES     50
+       uintptr_t set_tlb_caching_invalid_entries_pmd =3D ((unsigned
long)set_tlb_caching_invalid_entries) & PMD_MASK;
+       // TODO the test_addr as defined below could go into another pud...
+       uintptr_t test_addr =3D set_tlb_caching_invalid_entries_pmd + 2
* PMD_SIZE;
+       pmd_t valid_pmd;
+       u64 satp;
+       int i =3D 0;
+
+       /* To ease the page table creation */
+       // TODO use variable instead, like in the clean, nop stap_mode too
+       disable_pgtable_l5();
+       disable_pgtable_l4();
+
+       /* Establish a mapping for set_tlb_caching_invalid_entries() in sv3=
9 */
+       create_pgd_mapping(early_pg_dir,
+                          set_tlb_caching_invalid_entries_pmd,
+                          (uintptr_t)early_pmd,
+                          PGDIR_SIZE, PAGE_TABLE);
+
+       /* Handle the case where set_tlb_caching_invalid_entries
straddles 2 PMDs */
+       create_pmd_mapping(early_pmd,
+                          set_tlb_caching_invalid_entries_pmd,
+                          set_tlb_caching_invalid_entries_pmd,
+                          PMD_SIZE, PAGE_KERNEL_EXEC);
+       create_pmd_mapping(early_pmd,
+                          set_tlb_caching_invalid_entries_pmd + PMD_SIZE,
+                          set_tlb_caching_invalid_entries_pmd + PMD_SIZE,
+                          PMD_SIZE, PAGE_KERNEL_EXEC);
+
+       /* Establish an invalid mapping */
+       create_pmd_mapping(early_pmd, test_addr, 0, PMD_SIZE, __pgprot(0));
+
+       /* Precompute the valid pmd here because the mapping for
pfn_pmd() won't exist */
+       valid_pmd =3D
pfn_pmd(PFN_DOWN(set_tlb_caching_invalid_entries_pmd), PAGE_KERNEL);
+
+       local_flush_tlb_all();
+       satp =3D PFN_DOWN((uintptr_t)&early_pg_dir) | SATP_MODE_39;
+       csr_write(CSR_SATP, satp);
+
+       /*
+        * Set stvec to after the trapping access, access this invalid mapp=
ing
+        * and legitimately trap
+        */
+       // TODO: Should I save the previous stvec?
+#define ASM_STR(x)     __ASM_STR(x)
+       asm volatile(
+               "la a0, 1f                              \n"
+               "csrw " ASM_STR(CSR_TVEC) ", a0         \n"
+               "ld a0, 0(%0)                           \n"
+               ".align 2                               \n"
+               "1:                                     \n"
+               :
+               : "r" (test_addr)
+               : "a0"
+       );
+
+       /* Now establish a valid mapping to check if the invalid one
is cached */
+       early_pmd[pmd_index(test_addr)] =3D valid_pmd;
+
+       /*
+        * Access the valid mapping multiple times: indeed, we can't use
+        * sfence.vma as a barrier to make sure the cpu did not reorder acc=
esses
+        * so we may trap even if the uarch does not cache invalid entries.=
 By
+        * trying a few times, we make sure that those uarchs will see the =
right
+        * mapping at some point.
+        */
+
+       i =3D NR_RETRIES_CACHING_INVALID_ENTRIES;
+
+#define ASM_STR(x)     __ASM_STR(x)
+       asm_volatile_goto(
+               "la a0, 1f                                      \n"
+               "csrw " ASM_STR(CSR_TVEC) ", a0                 \n"
+               ".align 2                                       \n"
+               "1:                                             \n"
+               "addi %0, %0, -1                                \n"
+               "blt %0, zero, %l[caching_invalid_entries]      \n"
+               "ld a0, 0(%1)                                   \n"
+               :
+               : "r" (i), "r" (test_addr)
+               : "a0"
+               : caching_invalid_entries
+       );
+
+       csr_write(CSR_SATP, 0ULL);
+       local_flush_tlb_all();
+
+       /* If we don't trap, the uarch does not cache invalid entries! */
+       tlb_caching_invalid_entries =3D false;
+       goto clean;
+
+caching_invalid_entries:
+       csr_write(CSR_SATP, 0ULL);
+       local_flush_tlb_all();
+
+       tlb_caching_invalid_entries =3D true;
+clean:
+       memset(early_pg_dir, 0, PAGE_SIZE);
+       memset(early_pmd, 0, PAGE_SIZE);
+
+       enable_pgtable_l4();
+       enable_pgtable_l5();
+}
 #endif

 /*
@@ -1040,6 +1161,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 #endif

 #if defined(CONFIG_64BIT) && !defined(CONFIG_XIP_KERNEL)
+       set_tlb_caching_invalid_entries();
        set_satp_mode(dtb_pa);
 #endif

@@ -1290,6 +1412,9 @@ static void __init setup_vm_final(void)
        local_flush_tlb_all();

        pt_ops_set_late();
+
+       pr_info("uarch caches invalid entries: %s",
+               tlb_caching_invalid_entries ? "yes": "no");
 }
 #else
 asmlinkage void __init setup_vm(uintptr_t dtb_pa)


> Cheers,
> Prabhakar
