Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121477B7052
	for <lists+linux-arch@lfdr.de>; Tue,  3 Oct 2023 19:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjJCRyA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Oct 2023 13:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjJCRx7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Oct 2023 13:53:59 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680ADB4;
        Tue,  3 Oct 2023 10:53:55 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 853B03200BC7;
        Tue,  3 Oct 2023 13:53:53 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 03 Oct 2023 13:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1696355633; x=1696442033; bh=Em
        ic7Z1y2XZwljvtzupGq8cvsW20UYl18kfH5lRmznc=; b=SVgICDf5yRfXlPfjVA
        eJjhhCQ5vlaRDHcsf4qzkxfn1pHyrodiKdBSYIFXdGH5RdW16rKjVmZb2vsdyG7c
        QbgXUO51hZxEeU8wyYkicxXRRO9hmJOXOWx8LdxmHYu4Y4VtPYYhhmkZR5DhHUZ1
        G8Ch/Jhr2s6rrDdPObHMVRt2i/Ns49x0GQkkKPsQRJ9mGTeKs4rG19UT73l0G075
        5CT1m1WSdxJc7sdfv9DiWwA9AZ0TzTXOU+i5vcyA6SjyQwtVBKBuiRuaZtsudV/p
        wvpqGu+VwOWQs2P7bQjJ5xoVND3HEWAq85vRrvnJGuO2AOlHxhIFEdXZXU3UVFuH
        vOaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696355633; x=1696442033; bh=Emic7Z1y2XZwl
        jvtzupGq8cvsW20UYl18kfH5lRmznc=; b=D4IZ3l0sid9yWdF4s01/W4fAza+J9
        /GBG82dS97gc/2a1WI3A0fpWzmk9qB8yvNiZcYTqgPKxxWxa7mBu2FbOByDYF13X
        inmrKfUvjz3qolbP+4ZTi7wC6YKxA5ZU7x+iVwCt8e32kPIdPtnFwnekt3qLXGe1
        /sOHcoh/4+Xw5j53Ay/fApPzqrr9k2aVMpU7MCFn2y5/kI0ex4VTMJLKovi4PU/x
        MY4/G1FyEBW4c+e7xk52zIsQKLLXxeMyxA3jcMneQKSaYfrgafargegWzHmBMhlx
        zCF1xNxc7hKl+GB16oBOc2K56EWvOaCYsAz5BEKp2KIzxFiDL5Pdh+Gog==
X-ME-Sender: <xms:MFUcZa6ybrbn3j4CnryrpW4KN3rL2NsG-Z3-_u307Aa3_motc59mtQ>
    <xme:MFUcZT6ECAbje1R99ix4e00Z_VsFORhSxojWzbat72Fi-yMjsOROEkhYgx_6qH_qx
    rXnPvpL-4zvd5TIa1k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeejgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:MFUcZZda-NwqB9Mqs1HNnB42vks08vfyg76bindlcpDozi1AtQc0Tw>
    <xmx:MFUcZXKoOfH267TFMW0ZSu1B2EYoqvRCvWB773MZbSAVVg-CyeZwDw>
    <xmx:MFUcZeLoPuQXOfLTkdA78loo4kVyLHhHwf5GXW7BXQ4e20Zgkpgxmg>
    <xmx:MVUcZbB3mUgOQ0sTZgWdjM5IkhcO4EIVQjlNwgwb8GARDLmcEMBoFg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8B48FB60089; Tue,  3 Oct 2023 13:53:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <ac03a633-5d74-4735-a7bb-0214f54242c9@app.fastmail.com>
In-Reply-To: <cdada842-2a7e-5f1d-eea3-3d99b637c26b@intel.com>
References: <20230628230935.1196180-1-sohil.mehta@intel.com>
 <20230710185124.3848462-1-sohil.mehta@intel.com>
 <5748f659-4063-0e18-c5d4-941a863d0d93@intel.com>
 <cdada842-2a7e-5f1d-eea3-3d99b637c26b@intel.com>
Date:   Tue, 03 Oct 2023 19:53:31 +0200
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
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] syscalls: Cleanup references to sys_lookup_dcookie()
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 3, 2023, at 19:47, Sohil Mehta wrote:
> Arnd, is this a good candidate for 6.7? Though old, the patch applies
> cleanly on 6.6-rc4. I can re-send this one if you would prefer that.
>

Thanks a lot for the reminder, I've added it to my asm-generic
branch for v6.7 now, it should be in linux-next tomorrow.

     Arnd
