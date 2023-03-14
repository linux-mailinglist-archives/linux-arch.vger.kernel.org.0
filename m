Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EB06B965A
	for <lists+linux-arch@lfdr.de>; Tue, 14 Mar 2023 14:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjCNNeO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Mar 2023 09:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjCNNdv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Mar 2023 09:33:51 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16271A42D9;
        Tue, 14 Mar 2023 06:30:10 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2920B5821F5;
        Tue, 14 Mar 2023 09:29:43 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 14 Mar 2023 09:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678800583; x=1678807783; bh=Qn
        n6+IRlA6XmC3RNcByM4d2mBBa6FJzTP5+rNGAmgqQ=; b=l0eyk2SscWqQXi3nN9
        vnwKklkDMOBbio3FURjn+Bpy5ZCCHqD7SXA2v+BUfjXe1BbzLFjcfb25/BruINog
        onaH7av+oru1iinokD5UUiEeYIqtJ4Kg0Aaw3Jyu7kJoa5hC/ryiPqpqD0+X+sOJ
        FieL8AvIjoBwxof4E0o5p50Mh1gFkpKmOnVN7D2n9Uo7ZdDZdYgQe9cUfOWE+JrW
        p86l7w+sGr28aPa453rQaedXZDe/hyiWohR4p5mmcdQIt2qWYJ0VXYA2LYqe1OUd
        JQPYZToHVlFK+fVirY5mU41ejN0XAs/2b+rjU+KutLPBpwek3GAYJy77YAE7Bo9E
        Ns8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678800583; x=1678807783; bh=Qnn6+IRlA6XmC
        3RNcByM4d2mBBa6FJzTP5+rNGAmgqQ=; b=muI3krkr5ue5EMCztpZtmQZ230dlq
        NHJXMizg7ZDVutrIItwGB3wj5a9w+UVr7DQ4IRcR6wKCtDHeZsdDsh9rziRf2XAH
        mxxqap5mBCxs0lC4pBrZPd7JOP9kd1YX5PiiJcYQt2onJXwxplgJCBwSAbYMb6Cq
        fGyUaX9Uinp4emKXQz5EIRdpmipCqp8W8d08in+y59gcZSY9E4OJJsj4As+eTHoo
        3PY9CHhQINjCiLqGfmfYfGTWB1j+eIKEGGz3FJr4TbBVq9Wyb/fTeXqVAsmompxu
        RfCJU/jqTWOgjK8AJTMoV28vA4VEkIhF2lTUuA8m7IO/NIt9HpIky6etQ==
X-ME-Sender: <xms:w3YQZJSCb_3giOoPBWmGdJr0v16f8dcQcUyLiL5zfPo8VxsKkn1OtA>
    <xme:w3YQZCytMRjTg7DeqcEY6RSZcXj2S4T9q459zn3UFhxGuhfYt5e6kx6BMIPfSWSIc
    CzuGYJb2CPQ0iocqrU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddviedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:w3YQZO2brLJWdo_vKkMgJR0vGT5zuZpiucx8_gOIXgOjsEC1U806IA>
    <xmx:w3YQZBC-9LDWKmMu9X3tsMNXrvS3UAJaFDikuMJ42dcXA8yygsg0uQ>
    <xmx:w3YQZCgR-43tuZG_it8C2HtSXGcNWkn1DTX5oVxBCvzRpCe7LvzoRA>
    <xmx:x3YQZPL08u_hWRCsNR2T79xmO1vK9oix1JlS8BCuoOiWur93kzZQiw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 99DEBB60086; Tue, 14 Mar 2023 09:29:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-221-gec32977366-fm-20230306.001-gec329773
Mime-Version: 1.0
Message-Id: <f8bdc245-38b0-4973-bd01-34f594a0ede4@app.fastmail.com>
In-Reply-To: <20230314121216.413434-2-schnelle@linux.ibm.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
 <20230314121216.413434-2-schnelle@linux.ibm.com>
Date:   Tue, 14 Mar 2023 14:29:18 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "Richard Henderson" <richard.henderson@linaro.org>,
        "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
        "Matt Turner" <mattst88@gmail.com>,
        "Russell King" <linux@armlinux.org.uk>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Michal Simek" <monstr@monstr.eu>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Helge Deller" <deller@gmx.de>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        "Rich Felker" <dalias@libc.org>,
        "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        "David S . Miller" <davem@davemloft.net>,
        "Richard Weinberger" <richard@nod.at>,
        "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
        "Johannes Berg" <johannes@sipsolutions.net>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Alan Stern" <stern@rowland.harvard.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-pci@vger.kernel.org, "Arnd Bergmann" <arnd@kernel.org>,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org
Subject: Re: [PATCH v3 01/38] Kconfig: introduce HAS_IOPORT option and select it as
 necessary
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 14, 2023, at 13:11, Niklas Schnelle wrote:
> We introduce a new HAS_IOPORT Kconfig option to indicate support for I/O
> Port access. In a future patch HAS_IOPORT=n will disable compilation of
> the I/O accessor functions inb()/outb() and friends on architectures
> which can not meaningfully support legacy I/O spaces such as s390. Also
> add dependencies on HAS_IOPORT for the ISA and HAVE_EISA config options
> as these busses always go along with HAS_IOPORT.
>
> The "depends on" relations on HAS_IOPORT in drivers as well as ifdefs
> for HAS_IOPORT specific sections will be added in subsequent patches on
> a per subsystem basis.

I think it would be helpful to enumerate which architectures
do not get HAS_IOPORT added, as they will be affected more.

> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

If there are no objections, I could send this first patch for the
asm-generic tree as a preparation for 6.3, so we are able to merge
the other patches through subsystem maintainer tree for 6.4.

arch/loongarch/ will now also need to select HAS_IOPORT
uncontitionally, this architecture was added after you
sent v2.

> diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
> index a98940e64243..5eeacc72e4da 100644
> --- a/arch/parisc/Kconfig
> +++ b/arch/parisc/Kconfig
> @@ -47,6 +47,7 @@ config PARISC
>  	select MODULES_USE_ELF_RELA
>  	select CLONE_BACKWARDS
>  	select TTY # Needed for pdc_cons.c
> +	select HAS_IOPORT if PCI

It's also needed for EISA and I think you should select it
from CONFIG_GSC in drivers/parisc/Kconfig for this purpose.

This could also be 'select HAS_IOPORT if PCI || EISA', but
that would require removing the 'depends on HAS_IOPORT'
under drivers/eisa/.

>  	select HAVE_DEBUG_STACKOVERFLOW
>  	select HAVE_ARCH_AUDITSYSCALL
>  	select HAVE_ARCH_HASH
> @@ -131,6 +132,7 @@ config STACKTRACE_SUPPORT
> 
>  config ISA_DMA_API
>  	bool
> +	depends on HAS_IOPORT
> 

This line is not really needed since there is no way to
enable ISA_DMA_API.

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index a6c4407d3ec8..f7de646c074a 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -188,6 +188,7 @@ config PPC
>  	select GENERIC_SMP_IDLE_THREAD
>  	select GENERIC_TIME_VSYSCALL
>  	select GENERIC_VDSO_TIME_NS
> +	select HAS_IOPORT			if PCI
>  	select HAVE_ARCH_AUDITSYSCALL
>  	select HAVE_ARCH_HUGE_VMALLOC		if HAVE_ARCH_HUGE_VMAP
>  	select HAVE_ARCH_HUGE_VMAP		if PPC_RADIX_MMU || PPC_8xx
> @@ -1070,7 +1071,6 @@ menu "Bus options"
> 
>  config ISA
>  	bool "Support for ISA-bus hardware"
> -	depends on PPC_CHRP
>  	select PPC_I8259
>  	help
>  	  Find out whether you have ISA slots on your motherboard.  ISA is the

This line looks wrong, I think we should keep that dependency.
Did you get a circular dependency if you leave it in?

> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index a825bf031f49..634dd42532f3 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -162,6 +162,7 @@ config X86
>  	select GUP_GET_PXX_LOW_HIGH		if X86_PAE
>  	select HARDIRQS_SW_RESEND
>  	select HARDLOCKUP_CHECK_TIMESTAMP	if X86_64
> +	select HAS_IOPORT
>  	select HAVE_ACPI_APEI			if ACPI
>  	select HAVE_ACPI_APEI_NMI		if ACPI
>  	select HAVE_ALIGNED_STRUCT_PAGE		if SLUB
> @@ -2893,6 +2894,7 @@ if X86_32
> 
>  config ISA
>  	bool "ISA support"
> +	depends on HAS_IOPORT
>  	help

HAS_IOPORT is selected unconditionally already, so this doesn't
really do anything.

> diff --git a/lib/Kconfig.kgdb b/lib/Kconfig.kgdb
> index 3b9a44008433..c68e4d9dcecb 100644
> --- a/lib/Kconfig.kgdb
> +++ b/lib/Kconfig.kgdb
> @@ -121,7 +121,8 @@ config KDB_DEFAULT_ENABLE
> 
>  config KDB_KEYBOARD
>  	bool "KGDB_KDB: keyboard as input device"
> -	depends on VT && KGDB_KDB && !PARISC
> +	depends on HAS_IOPORT
> +	depends on VT && KGDB_KDB
>  	default n

This loses the !PARISC dependency, which I don't think is
intentional. The added HAS_IOPORT dependency makes sense
here, but I think this should be in a different patch
and not in the preparation.

    Arnd
