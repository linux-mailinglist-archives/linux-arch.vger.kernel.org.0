Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE1D74268A
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jun 2023 14:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjF2Mg0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Jun 2023 08:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjF2MgR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jun 2023 08:36:17 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9F6297B;
        Thu, 29 Jun 2023 05:36:15 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.west.internal (Postfix) with ESMTP id 3C0B92B00163;
        Thu, 29 Jun 2023 08:36:08 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 29 Jun 2023 08:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1688042167; x=1688049367; bh=bT
        G+9AqapEnTzTdZN+3/z4mAZ7LW415XlukWbIMXEK4=; b=jVer3ZsYEpv4oKp9MB
        szsrrrdYGu7rGZrQTOVLMkGALoFHHLvc/oUUpXJBoXJgdCfT0l7aA0yKhATrYNXB
        aEGN9jvcC01pqiHdFsqq0bkFFSz9UIn0wpYtG5wYSyHBgIUb0q0WF10Dn3D0ys+Q
        XdVTz1xDdvBF5BWZT8QJkN/TJUgNTFQEn9uRiImRIIIxVlZAUYgfDYxAZN24C9If
        0fvLO/7Vh+JJJx9ib3bnVyk06XlQdUmqqoWItzk2IhpGynOSTiS1PFOrwsJCeCaJ
        8UiDOATEhC65kKFJEjC7rOkzppp5TX9XQuMvRoXskdiug/iaC/tnwPy1ygPdzaL6
        IoZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688042167; x=1688049367; bh=bTG+9AqapEnTz
        TdZN+3/z4mAZ7LW415XlukWbIMXEK4=; b=CccPJWvx1a+Oz1MM5Taiu9fsGftW9
        hmgBcLqXYChcnfp2nv6RWUg7M5kQcytbmDfhV1AVipcw49+CmNKous2ER6JLcGud
        qLKDK3EFXotIhbICdzx3r91mhkebGgUqVWBxeOtOqIwIjt2VLx2+7M0e0ZNBw8IY
        QYBew9HSxFvupkHfoU1p8ZntBi5WUvQWBmTXQhafzKFZRTGtPdZIsRBX2guG6EvC
        jm91VDAmWV04RD50eKeuNQ1gIbDXgSNCl/ADV15oAHykwZ0L0pLZZYK3u1cr3+Rr
        x7zXD2MAiXbufbU1CsLjDKzyEFWnoX4+00s21o08yDXbrmZmwqDH+dXBg==
X-ME-Sender: <xms:tnqdZAyITayvFU5PbWEsgwbjYWgt1_bFD3KxUqWmvV0MpPRpzRhMYw>
    <xme:tnqdZETRQyAQkFjh37a8uYBhXLeGI9R7f1m3td7LD-JziB80SvWJeQz0ASta2bqx9
    LtzynNQufcPspiPv5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdeggdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:t3qdZCWK84TlQOUoGax5_YXtDLllqy8UMuSas5speVwKDdAYHHtFmg>
    <xmx:t3qdZOh7zh5gc4FrE0MBs27VLcYOiuEURtr1UYpC_ojWWV1ts5U5xw>
    <xmx:t3qdZCD2YEfxCMDoMp6Bks-zFbCY2rQklJKHTChqpgGWw39PgvnhXA>
    <xmx:t3qdZKjiEc4oaeDQe8Jc0rTS3lifMyHCY8K24zrYhOb09JLKNV8fH1kx3iQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D6555B60086; Thu, 29 Jun 2023 08:36:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <80e3a583-805e-4e8f-a67b-ebe2e4b9a7e5@app.fastmail.com>
In-Reply-To: <20230629121952.10559-8-tzimmermann@suse.de>
References: <20230629121952.10559-1-tzimmermann@suse.de>
 <20230629121952.10559-8-tzimmermann@suse.de>
Date:   Thu, 29 Jun 2023 14:35:46 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Helge Deller" <deller@gmx.de>, "Daniel Vetter" <daniel@ffwll.ch>,
        "Dave Airlie" <airlied@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Frederic Weisbecker" <frederic@kernel.org>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        "Sami Tolvanen" <samitolvanen@google.com>,
        "Juerg Haefliger" <juerg.haefliger@canonical.com>
Subject: Re: [PATCH 07/12] arch/x86: Declare edid_info in <asm/screen_info.h>
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 29, 2023, at 13:45, Thomas Zimmermann wrote:
> The global variable edid_info contains the firmware's EDID information
> as an extension to the regular screen_info on x86. Therefore move it to
> <asm/screen_info.h>.
>
> Add the Kconfig token ARCH_HAS_EDID_INFO to guard against access on
> architectures that don't provide edid_info. Select it on x86.

I'm not sure we need another symbol in addition to
CONFIG_FIRMWARE_EDID. Since all the code behind that
existing symbol is also x86 specific, would it be enough
to just add either 'depends on X86' or 'depends on X86 ||
COMPILE_TEST' there?

      Arnd
