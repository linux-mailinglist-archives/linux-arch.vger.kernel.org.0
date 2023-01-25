Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC97D67B94A
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jan 2023 19:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjAYS2b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Jan 2023 13:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbjAYS23 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Jan 2023 13:28:29 -0500
Received: from fx409.security-mail.net (smtpout140.security-mail.net [85.31.212.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB891421A
        for <linux-arch@vger.kernel.org>; Wed, 25 Jan 2023 10:28:25 -0800 (PST)
Received: from localhost (fx409.security-mail.net [127.0.0.1])
        by fx409.security-mail.net (Postfix) with ESMTP id A2BC734960B
        for <linux-arch@vger.kernel.org>; Wed, 25 Jan 2023 19:28:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1674671303;
        bh=VkZlMx/sz061Cm6YfPqH8mfzLS3IhHFJZRhlNITSu+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=PgYGGINfgdlge6AJuhvcxeUH6V0qclH7r/w0zv6MkFIIQyoW7OeQf49pR+PV9NV8p
         fmlbHY2+Czp6L7ta7EUF/GbRH7PuBhBb899yvjM+2Df0hJO4Fc0FQaeYABlP0TUwps
         UDIcw6zHlNZBkl1Vkr8vv3SWe5LXy8V23EIzkm1M=
Received: from fx409 (fx409.security-mail.net [127.0.0.1]) by
 fx409.security-mail.net (Postfix) with ESMTP id 20C0434940E; Wed, 25 Jan
 2023 19:28:23 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx409.security-mail.net (Postfix) with ESMTPS id 23501349405; Wed, 25 Jan
 2023 19:28:22 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id DD3A827E0493; Wed, 25 Jan 2023
 19:28:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id BBF0027E0491; Wed, 25 Jan 2023 19:28:21 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 G_ghmxyD1iYT; Wed, 25 Jan 2023 19:28:21 +0100 (CET)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 4BBCB27E0461; Wed, 25 Jan 2023
 19:28:21 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <d944.63d174c6.208cc.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu BBF0027E0491
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1674671301;
 bh=VkZlMx/sz061Cm6YfPqH8mfzLS3IhHFJZRhlNITSu+c=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=N3SEBnibRaD53LXAAbH/OUxooZ7n0SvOBr0+syTYe+WDdImAFJ/mdTgLKfIxv6LJf
 I5CIDXC/mDxLizitRLdE+s3wz2ripLYND6B2KWw3ej4vQLa/Hu4ztfFI0ZHqW9QVVJ
 8DSlKZjshZ0JVrBB2b7nAJJF8/TFydx8Kexe3QIU=
Date:   Wed, 25 Jan 2023 19:28:20 +0100
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Yann Sionneau <ysionneau@kalray.eu>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
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
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Qi Liu <liuqi115@huawei.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Benjamin Mugnier <mugnier.benjamin@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-audit@redhat.com,
        linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH v2 01/31] Documentation: kvx: Add basic
 documentation
Message-ID: <20230125182820.GD5952@tellis.lin.mbt.kalray.eu>
References: <20230120141002.2442-1-ysionneau@kalray.eu>
 <20230120141002.2442-2-ysionneau@kalray.eu> <Y8z7v53A/UDKFd7j@debian.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y8z7v53A/UDKFd7j@debian.me>
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

Hi Bagas,

Thanks for taking your time and effort to improve the documentation.
We not only need to clean the documention syntax and wording but also
its content. I am tempted to apply all your proposed changes first and
then work on improving and correcting the documentation.

However I am not very sure on how to integrate your changes and give
proper contribution attributions. Any insights on this would be greatly
appreciated.

Thanks
-- Jules





