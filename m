Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BBF7B6F09
	for <lists+linux-arch@lfdr.de>; Tue,  3 Oct 2023 18:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240630AbjJCQzg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Oct 2023 12:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240501AbjJCQzf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Oct 2023 12:55:35 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C2ED7;
        Tue,  3 Oct 2023 09:55:24 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 70DFF3200B6E;
        Tue,  3 Oct 2023 12:55:22 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 03 Oct 2023 12:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1696352121; x=1696438521; bh=bM
        N3ahYNWDfnd39aNSh3WGWAh25s8Cnm4TD3ZVFC+Qc=; b=We9PtvKNlGv7dvx37W
        gvw7JROLcaGwJW81HX+bOX0v2ZSUP/FkK60Nja7JSezA8Ob2D0JJaM7KQC/4B6dg
        3FkAc8zXsJvBYYrEiEGhlts0rBcAQBkEEkZxcRD8wblX+A+aVbt0zSkJeOlrXFgi
        dN7ZDRXkZlF1ngYu9L3h3KTZz5wgJT15OaClA6MhdE+Ie2/n9E4FdAEqBCke7V45
        qgCQglaN5c/rDOtC4r/ZFMPK1B8A74TPfSdNjeAAtBOx42ADjrvDSWXND2UhaJYD
        5YvLx9+ARgBv0tNv8EitzYh4jhk3nwcKhWO2EtFf3FYOQpe+Kzwo0886VIYCSSak
        FbiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696352121; x=1696438521; bh=bMN3ahYNWDfnd
        39aNSh3WGWAh25s8Cnm4TD3ZVFC+Qc=; b=edST69BZgCUs+ZJ5Nwm6y0b6a7XVj
        LnT6QaEQ1fCdfOq8oJrgP+uusP0BOtTgrKIYuWxLUTxC9bJzfbgS+bOwL8TkPZ8n
        gzUIAj61U8YvG4zqACt88GvvJWIHP2aWutbDQ8lpMTCxocYi7tD7Rn5MA0+5no+O
        4vmTwvg32YQPkeWZIBdyj8xBY/Emsv1vpyJA73bIy+cjoWSq9VVwuegpBMEIkwY7
        2G6ULyIH236et9sQ5eRKYfYs9ktCxNHMF6sR8Sx3PEIPcaCOLvFoJ5UWS/szXZB/
        6SR7SQ+60qLHjSOD8gR/StWwKTyRCCGoLP9UjNXJtYiixRKvOkDMWAG5w==
X-ME-Sender: <xms:eUccZf3QD16gRjigQ-lnvux8KWufYA-tMrz4OmKvx9beKPG-rMK71Q>
    <xme:eUccZeFlsZlc2R7zU0sC_H0pnDxakM1VzHn_5OQQH7FPcmbIv1ffaq5Fr1omoKxT7
    t-9JNQyrtScrBniFq4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeejgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:eUccZf7e3NINH8fFhSQFtACK-Iav_OJuOH9V1Rc8v-iFOBNtWwMvRw>
    <xmx:eUccZU2SblP8ob6jk4qVAkiKY_cyvr0uR7YceifT1iHcvDA-3O3fzg>
    <xmx:eUccZSE9xb4wRT9nXRtG9aZW26cHNMY4DwnVstiYc0I_8aejN9YsMw>
    <xmx:eUccZeFKEletdmbu8CfqX7M2xGLOaFB1G6i4zj7LgSNncIPAD6-uWA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 48524B60089; Tue,  3 Oct 2023 12:55:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <231994b0-ca11-4347-8d93-ce66fdbe3d25@app.fastmail.com>
In-Reply-To: <487836fc-7c9f-2662-66a4-fa5e3829cf6b@intel.com>
References: <20230914185804.2000497-1-sohil.mehta@intel.com>
 <487836fc-7c9f-2662-66a4-fa5e3829cf6b@intel.com>
Date:   Tue, 03 Oct 2023 18:54:59 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Sohil Mehta" <sohil.mehta@intel.com>, linux-api@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>
Cc:     "Richard Henderson" <richard.henderson@linaro.org>,
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
        "Heiko Carstens" <hca@linux.ibm.com>,
        "Vasily Gorbik" <gor@linux.ibm.com>,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        "Christian Borntraeger" <borntraeger@linux.ibm.com>,
        "Sven Schnelle" <svens@linux.ibm.com>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        "Rich Felker" <dalias@libc.org>,
        "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        "David S . Miller" <davem@davemloft.net>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Chris Zankel" <chris@zankel.net>,
        "Max Filippov" <jcmvbkbc@gmail.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        "Jiri Olsa" <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "Ian Rogers" <irogers@google.com>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        "Lukas Bulwahn" <lukas.bulwahn@gmail.com>,
        "Sergei Trofimovich" <slyich@gmail.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Rohan McLure" <rmclure@linux.ibm.com>,
        "Andreas Schwab" <schwab@linux-m68k.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Brian Gerst" <brgerst@gmail.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Rick Edgecombe" <rick.p.edgecombe@intel.com>,
        "Mark Brown" <broonie@kernel.org>,
        "Deepak Gupta" <debug@rivosinc.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] arch: Reserve map_shadow_stack() syscall number for all
 architectures
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 3, 2023, at 18:35, Sohil Mehta wrote:
> On 9/14/2023 11:58 AM, Sohil Mehta wrote:
>> commit c35559f94ebc ("x86/shstk: Introduce map_shadow_stack syscall")
>> recently added support for map_shadow_stack() but it is limited to x86
>> only for now. There is a possibility that other architectures (namely,
>> arm64 and RISC-V), that are implementing equivalent support for shadow
>> stacks, might need to add support for it.
>> 
>> Independent of that, reserving arch-specific syscall numbers in the
>> syscall tables of all architectures is good practice and would help
>> avoid future conflicts. map_shadow_stack() is marked as a conditional
>> syscall in sys_ni.c. Adding it to the syscall tables of other
>> architectures is harmless and would return ENOSYS when exercised.
>> 
>> Note, map_shadow_stack() was assigned #453 during the merge process
>> since #452 was taken by fchmodat2().
>> 
>> For Powerpc, map it to sys_ni_syscall() as is the norm for Powerpc
>> syscall tables.
>> 
>> For Alpha, map_shadow_stack() takes up #563 as Alpha still diverges from
>> the common syscall numbering system in the other architectures.
>> 
>> Link: https://lore.kernel.org/lkml/20230515212255.GA562920@debug.ba.rivosinc.com/
>> Link: https://lore.kernel.org/lkml/b402b80b-a7c6-4ef0-b977-c0f5f582b78a@sirena.org.uk/
>> 
>> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
>> ---
>
> Gentle ping...
>
> Are there any additional comments? It applies cleanly on 6.6-rc4.
>
> Or does it seem ready to be merged? It has the following
> acknowledgements until now:
>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

If you like, I can pick this up for 6.7 through the asm-generic
tree. If you think this should be part of 6.6, I would suggest
to merge it through the tree that originally contained the
syscall code.

      Arnd
