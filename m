Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6778C7D9FC6
	for <lists+linux-arch@lfdr.de>; Fri, 27 Oct 2023 20:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346109AbjJ0SV2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Oct 2023 14:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjJ0SV1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Oct 2023 14:21:27 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8D118A;
        Fri, 27 Oct 2023 11:21:25 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id BCAB23200991;
        Fri, 27 Oct 2023 14:21:20 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 27 Oct 2023 14:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1698430880; x=1698517280; bh=kq
        Kh9AT18iwbdinBisTYEW8NEyJ9dHdSrh4I4KDbbCg=; b=OlQzfTgaBznW8G1AAC
        678uEBo1wcRy8QXbXPJrmd2Bhdt086OqcMMcQh7Py2+CiD9PZ2x7bF3WaGkCbEIF
        WX9kgWEShCOZSVOa7qeviHy3ycPdqga1yKkZheSo4xCh8URzm/n+UAWOMM640tYc
        WhDDkyapXXQs1o+vZG8t9LhcqwcdZeR6Ij5EDztNNfVh6ebw4F5rr4C2W4Wt1egH
        q+gSPHEzv4vHleEWvipbqLZmAFE3Q58Lsrk4P+SU4wGbtcoDnADuRpAtgnfsp4bb
        K0qoDbF28lQgjKplzbhM8ZFwirt7EYPjZtDWnmogBqFuErYYWFDu/i2xxO+b7ojR
        +ahw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698430880; x=1698517280; bh=kqKh9AT18iwbd
        inBisTYEW8NEyJ9dHdSrh4I4KDbbCg=; b=Uu2eWeEtm12OFZkAgZtZwC05t0MFc
        D4hICCKxVhWGjGW6e8pov8z58/t34xXpNouDi4XeCQRJLSGTvMz07KKew7jrEnyY
        tWmAPX39D9l6nAAViIgihrgR99El5I5VMf3SPcl5oq2V5Vp+zrXXQMlR40WYzoye
        dx2BmoblD3x2hGiXobyQJwGP+i6UBfyDhWA7L7ppmWbjkihv9ygcRYMUs9kJhxNO
        a2UpdlTWiFNk6H6O9v8g1mVZzoeRSHOlrDQ5/P9pNWV6KeogheSlD8oxoky8DiLT
        MLtaB+n39kwt2h6KlnIjIdEXP6NFxIP/DKokj4HrTx55qtGchO5Fq1y7Q==
X-ME-Sender: <xms:nv87ZdTSbIk2wFRQNevWIoUnqNC42uqmfKUuL-8kovH0XuUVjFc2Wg>
    <xme:nv87ZWxYJsQtXdDnbT7YIlvoeU4zBKzTEnNIlF2WTZAMBNtOItauj57MYysyPEqSp
    1rTz9-tlUnt3D9bRyc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeggdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:nv87ZS0GtRqBfjYs-NUlTngGL9NLbL-cdbjhoIk51kLlYz_GDIY6GQ>
    <xmx:nv87ZVB7__653aagZOXTuD_dUMxksDm5esqjkE1cCu0QtdIaI1XjqQ>
    <xmx:nv87ZWgllWWa3lcPeNpdXfAGaVpepZy8Ob1SGVb6__sdI3q8mKmVww>
    <xmx:oP87ZdTnhJYKqmWsiAcB-9v_QBRvc4kLkKhqS9F5xLOunG2SM2elOA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2ABF6B60089; Fri, 27 Oct 2023 14:21:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <b86551ec-5f5d-4fee-9d79-01b04c30e447@app.fastmail.com>
In-Reply-To: <20231027171756.1241002-2-stephen.s.brennan@oracle.com>
References: <20231027171756.1241002-1-stephen.s.brennan@oracle.com>
 <20231027171756.1241002-2-stephen.s.brennan@oracle.com>
Date:   Fri, 27 Oct 2023 20:20:56 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Stephen Brennan" <stephen.s.brennan@oracle.com>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-debuggers@vger.kernel.org,
        "Mike Christie" <michael.christie@oracle.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Christian Brauner" <brauner@kernel.org>,
        "Petr Mladek" <pmladek@suse.com>, "Marco Elver" <elver@google.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Doug Anderson" <dianders@chromium.org>,
        "Maninder Singh" <maninder1.s@samsung.com>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Zhen Lei" <thunder.leizhen@huawei.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Zhaoyang Huang" <zhaoyang.huang@unisoc.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Sami Tolvanen" <samitolvanen@google.com>
Subject: Re: [PATCH v3 1/1] kernel/config: Introduce CONFIG_DEBUG_INFO_IKCONFIG
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 27, 2023, at 19:17, Stephen Brennan wrote:
> The option CONFIG_IKCONFIG allows the gzip compressed kernel
> configuration to be included into vmlinux or a module. In these cases,
> debuggers can access the config data and use it to adjust their behavior
> according to the configuration. However, distributions rarely enable
> this, likely because it uses a fair bit of kernel memory which cannot be
> swapped out.
>
> This means that in practice, the kernel configuration is rarely
> available to debuggers.
>
> So, introduce an alternative, CONFIG_DEBUG_INFO_IKCONFIG. This strategy,
> which is only available if IKCONFIG is not already built-in, adds a
> section ".debug_linux_ikconfig", to the vmlinux ELF. It will be stripped
> out of the final images, but will remain in the debuginfo files. So
> debuggers which rely on vmlinux debuginfo can have access to the kernel
> configuration, without incurring a cost to the kernel at runtime.
>
> The configuration is enabled whenever DEBUG_INFO=y and IKCONFIG!=y. The
> added section is not large compared to debug info sizes. It won't affect
> the runtime kernel at all, and this default will ensure that
> distributions intending to create useful debuginfo will get this new
> addition for kernel debuggers.
>
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
>  include/asm-generic/vmlinux.lds.h |  3 ++-
>  kernel/Makefile                   |  2 ++
>  kernel/configs-debug.S            | 18 ++++++++++++++++++
>  lib/Kconfig.debug                 | 15 +++++++++++++++
>  4 files changed, 37 insertions(+), 1 deletion(-)
>  create mode 100644 kernel/configs-debug.S

For asm-generic:

Acked-by: Arnd Bergmann <arnd@arndb.de>
