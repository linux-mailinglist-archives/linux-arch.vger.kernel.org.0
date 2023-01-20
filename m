Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B54675806
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 16:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjATPDs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Jan 2023 10:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjATPDr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Jan 2023 10:03:47 -0500
Received: from fx303.security-mail.net (mxout.security-mail.net [85.31.212.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020FFA316C
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 07:03:44 -0800 (PST)
Received: from localhost (fx303.security-mail.net [127.0.0.1])
        by fx303.security-mail.net (Postfix) with ESMTP id 714DE30F7A1
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 16:03:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1674227023;
        bh=UZzOxuculcf7mxi4XmJ6gsSDrAJaXvR6pX1yVHvffJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=kW7THbefwaBqq3E4MyuQwmr90ax0hQkfpZy6Np3+KLY3cc++QhhhKVSBM30a+UOn3
         oVqxEdH813kxvM5hlQNOTi/eFMG7llCjnSgPz33v8ttiDqA7igP87DRmjQ5TQyl3qe
         Cuf5U3fBQ82LLZmM8yVtNzEzjGSKIOEazPF0sfpI=
Received: from fx303 (fx303.security-mail.net [127.0.0.1]) by
 fx303.security-mail.net (Postfix) with ESMTP id 3221030F720; Fri, 20 Jan
 2023 16:03:43 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx303.security-mail.net (Postfix) with ESMTPS id 7CF1230F79F; Fri, 20 Jan
 2023 16:03:42 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 5696027E043A; Fri, 20 Jan 2023
 16:03:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 36BE627E0437; Fri, 20 Jan 2023 16:03:42 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 9zSUTNBWOY1C; Fri, 20 Jan 2023 16:03:42 +0100 (CET)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id D59A827E0430; Fri, 20 Jan 2023
 16:03:41 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <7f21.63caad4e.7b828.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 36BE627E0437
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1674227022;
 bh=C7HrnI5K8lMVKwfpvR2iIg1M1ljeou+P3mCJSMAG91Q=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=WDWoyVMbIMPbJepmJq7lETaMqJi8dXSis3WDlHnimStL/D6LcNyVKEyhwC0exaLEa
 /yI1hmzBWA0vpQxL61VK4pLGSFjwDaBXqRRCN+CNJkpmnVhmZT4IznmM53SL6OKcDp
 hoqf7NRBZhx1q/JOV6km7TyZQI9nicecKIciSZ5I=
Date:   Fri, 20 Jan 2023 16:03:40 +0100
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Yann Sionneau <ysionneau@kalray.eu>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Clement Leger <clement@clement-leger.fr>,
        Vincent Chardon <vincent.chardon@elsys-design.com>,
        Marc =?utf-8?b?UG91bGhpw6hz?= <dkm@kataplop.net>,
        Julian Vetter <jvetter@kalray.eu>,
        Samuel Jones <sjones@kalray.eu>,
        Ashley Lesdalons <alesdalons@kalray.eu>,
        Thomas Costis <tcostis@kalray.eu>,
        Marius Gligor <mgligor@kalray.eu>,
        Jonathan Borne <jborne@kalray.eu>,
        Julien Villette <jvillette@kalray.eu>,
        Luc Michel <lmichel@kalray.eu>,
        Louis Morhet <lmorhet@kalray.eu>,
        Julien Hascoet <jhascoet@kalray.eu>,
        Jean-Christophe Pince <jcpince@gmail.com>,
        Guillaume Missonnier <gmissonnier@kalray.eu>,
        Alex Michon <amichon@kalray.eu>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <git@xen0n.name>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        John Garry <john.garry@huawei.com>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Bibo Mao <maobibo@loongson.cn>,
        Atish Patra <atishp@atishpatra.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Qi Liu <liuqi115@huawei.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Benjamin Mugnier <mugnier.benjamin@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mm@kvack.org,
        Linux-Arch <linux-arch@vger.kernel.org>, linux-audit@redhat.com,
        linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH v2 09/31] kvx: Add build infrastructure
Message-ID: <20230120150340.GA5952@tellis.lin.mbt.kalray.eu>
References: <20230120141002.2442-1-ysionneau@kalray.eu>
 <20230120141002.2442-10-ysionneau@kalray.eu>
 <aa4d68b2-b5b5-4c17-a44f-7c6db443ea4c@app.fastmail.com>
 <20230120145316.GA4155@tellis.lin.mbt.kalray.eu>
 <9965e2d1-bae8-4ce7-911c-783c772e9ff1@app.fastmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9965e2d1-bae8-4ce7-911c-783c772e9ff1@app.fastmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 20, 2023 at 04:01:11PM +0100, Arnd Bergmann wrote:
> On Fri, Jan 20, 2023, at 15:53, Jules Maselbas wrote:
> > On Fri, Jan 20, 2023 at 03:39:22PM +0100, Arnd Bergmann wrote:
> >> On Fri, Jan 20, 2023, at 15:09, Yann Sionneau wrote:
> >> >      - Fix clean target raising an error from gcc (LIBGCC)
> >> 
> >> I had not noticed this on v1 but:
> >> 
> >> > +# Link with libgcc to get __div* builtins.
> >> > +LIBGCC	:= $(shell $(CC) $(DEFAULT_OPTS) --print-libgcc-file-name)
> >> 
> >> It's better to copy the bits of libgcc that you actually need
> >> than to include the whole thing. The kernel is in a weird
> > It was initialy using KCONFIG_CFLAGS which do not contains valid options
> > when invoking the clean target.
> >
> > I am not exactly sure what's needed by gcc for --print-libgcc-file-name,
> > my guess is that only the -march option matters, I will double check
> > internally with compiler peoples.
> >
> >> state that is neither freestanding nor the normal libc based
> >> environment, so we generally want full control over what is
> >> used. This is particularly important for 32-bit architectures
> >> that do not want the 64-bit division, but there are probably
> >> enough other cases as well.
> 
> To clarify: I meant you should not include libgcc.a at all but
> add the minimum set of required files as arch/kvx/lib/*.S.
Thanks for clarifying :)


-- Jules




