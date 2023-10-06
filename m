Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF887BC057
	for <lists+linux-arch@lfdr.de>; Fri,  6 Oct 2023 22:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbjJFUaB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Oct 2023 16:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbjJFUaA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Oct 2023 16:30:00 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD522CA;
        Fri,  6 Oct 2023 13:29:57 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B27D15C029C;
        Fri,  6 Oct 2023 16:29:54 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute5.internal (MEProxy); Fri, 06 Oct 2023 16:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1696624194; x=1696710594; bh=BV
        WEu9N65Klz9zi6Gx/GBcHI5219Lk7Ewdrm46HwRAI=; b=Cyjh3oDLSHJpzcsNZa
        w75pa0iUt10lzC04EpCQYcdZEjDTnv/tPDFYHO+2fdWjufExyQR6btU1KNdjdIyP
        SZOQzv8J9dOK3OIcKArRAxm4cr22YbYAI6PpobZfe6DKDJHidhvxhKw31lXPgre5
        2w/Ay/HyZqHcAMogC+zXGkQD1Q2ek6BpgdsnrsMvaW/YH+Gm4PihiZRIpEQE07Ow
        KXJ0/Ks8ncy6CMAgrl/ZcIccgBSYgDM5Kl/brIcRykKmzRBSl1+MPrF1KsMGdRzu
        WW6W1ggC6xMdgAuB+uyo1ze1+kgXHThZOI3/2QuzGcyWJBuZOYhKu57nMVYtouAx
        7y6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696624194; x=1696710594; bh=BVWEu9N65Klz9
        zi6Gx/GBcHI5219Lk7Ewdrm46HwRAI=; b=HPwTuAjkvSv0oKNRi/WQVcscNMLeP
        tfQA9zkSLtQAlfBS1aujUOGhDYP3TP6ugdbtr22XMmcf/CYhscnB7YyFlwIRxx/a
        2ecRJ4bc+I4ov40vlT++R2VkoEToklnNbpUVheENxuRw6mkcx1J0ioF5tvTvEDAi
        ScEnJU1Y3seSVJfddHBJEWqzpk2O9iE5+SX93so813eLS8BX72WpfNvL1gjQlJJG
        tMLpAZsTUjBnBuk1KhMPLdxeb57Lp20NFwMyFRwKy+66HxMj8nEKiJl65EByrcxX
        d5jA6elzp9qGf5oJK9Zbcj5bryYYpMwAcAs26mmudNY1rjcNM/pyuQ9sQ==
X-ME-Sender: <xms:QW4gZdiKlFx0M8VYmRzxPVSOi4E_vtuXyLnUfu7iI4TyE7Ix6wJ1EA>
    <xme:QW4gZSBKE3eiobViU-VJHw16Gxv6ZbVBMG87qFQ4_38-gyrhG2syjAChOcrfP7cwH
    SDV2tm6qFzVceYeVm0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgeeigddugeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:Qm4gZdGnrxQFe-c1alLBk2ykbYi6R6QcbmbhVk7uz8lT4cEchOoOMw>
    <xmx:Qm4gZSSmH9dQMj3IN1Up9MiMc_CntIGYL724GpVCyrhVhwc1in5u0Q>
    <xmx:Qm4gZazZMaWRqKo4cumVQhxw0gD1gWHvlautufcP-zY-Wrh5OxD7aQ>
    <xmx:Qm4gZeiETJkGDxBhgpqxzfwzpuTTSFImD35CpoKc7CZOPI3V05YJEA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A7E4B1700093; Fri,  6 Oct 2023 16:29:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <5d397fe4-a520-4336-b966-29bc5b798236@app.fastmail.com>
In-Reply-To: <3bd9a85c6f10279af6372cf17064978ad38c18b3.camel@intel.com>
References: <20230914185804.2000497-1-sohil.mehta@intel.com>
 <487836fc-7c9f-2662-66a4-fa5e3829cf6b@intel.com>
 <231994b0-ca11-4347-8d93-ce66fdbe3d25@app.fastmail.com>
 <622b95d8-f8ad-5bd4-0145-d6aed2e3c07d@intel.com>
 <3bd9a85c6f10279af6372cf17064978ad38c18b3.camel@intel.com>
Date:   Fri, 06 Oct 2023 22:29:32 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Rick Edgecombe" <rick.p.edgecombe@intel.com>,
        "Sohil Mehta" <sohil.mehta@intel.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Cc:     "Christian Borntraeger" <borntraeger@linux.ibm.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Helge Deller" <deller@gmx.de>,
        "Lukas Bulwahn" <lukas.bulwahn@gmail.com>,
        "Ian Rogers" <irogers@google.com>,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Max Filippov" <jcmvbkbc@gmail.com>,
        "Russell King" <linux@armlinux.org.uk>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        "chris@zankel.net" <chris@zankel.net>,
        "Heiko Carstens" <hca@linux.ibm.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Brian Gerst" <brgerst@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "Mark Brown" <broonie@kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "x86@kernel.org" <x86@kernel.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
        "Borislav Petkov" <bp@alien8.de>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "Jiri Olsa" <jolsa@kernel.org>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Michal Simek" <monstr@monstr.eu>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "Deepak Gupta" <debug@rivosinc.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Richard Henderson" <richard.henderson@linaro.org>,
        "Will Deacon" <will@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        "gor@linux.ibm.com" <gor@linux.ibm.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        "Matt Turner" <mattst88@gmail.com>,
        "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        "Sergei Trofimovich" <slyich@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Rohan McLure" <rmclure@linux.ibm.com>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "Sven Schnelle" <svens@linux.ibm.com>,
        "Rich Felker" <dalias@libc.org>,
        "Andreas Schwab" <schwab@linux-m68k.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH v2] arch: Reserve map_shadow_stack() syscall number for all
 architectures
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 6, 2023, at 22:01, Edgecombe, Rick P wrote:
> On Tue, 2023-10-03 at 10:18 -0700, Sohil Mehta wrote:
>> > If you like, I can pick this up for 6.7 through the asm-generic
>> > tree. If you think this should be part of 6.6, I would suggest
>> > to merge it through the tree that originally contained the
>> > syscall code.
>> > 
>> 
>> Dave, Ingo, would you prefer to take this patch through 6.6 or defer
>> it
>> until 6.7?
>> 
>> It's not necessarily a fix but it does help finish up the shstk
>> syscall
>> added with 6.6. Also, it might help reduce some merge conflicts later
>> if
>> newer syscalls are being added during the 6.7 window.
>
> Hi Arnd,
>
> It doesn't look like anyone is pouncing on the syscall number in linux-
> next currently. It might be nice to have this patch go through linux-
> next since it touches so many architectures. And it sounds like x86
> folk are ok with this, so if you could pick it up for 6.7 that would be
> great. Thanks!

Ok, I picked it up now, should be in linux-next starting next week.

     Arnd
