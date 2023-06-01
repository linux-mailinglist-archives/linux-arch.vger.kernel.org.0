Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7B3719E38
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jun 2023 15:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbjFANap (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Jun 2023 09:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbjFANaT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Jun 2023 09:30:19 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10691B5
        for <linux-arch@vger.kernel.org>; Thu,  1 Jun 2023 06:30:00 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9741a0fd134so123916566b.0
        for <linux-arch@vger.kernel.org>; Thu, 01 Jun 2023 06:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685626197; x=1688218197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0MHDOHZ+ksADoGSH1YMQnsp1jrJ4XOCHJuXFHrOLiU=;
        b=T4om4P1RzIZoDUAVXZfme2PWrAcGfnkYpcKpc1Y7uPZI1nrtTW6M2aIyr1jxBpJehV
         t/UYXCla7eAZpAYIvPbOO1gJxyXcpJVKGQ9PP7aoyffGzkUhY1UJE0NOakbVsfv3pMZr
         eAI8kMSEo+7AcJ5zsLNU7ObTZS/C2tzlxZv9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685626197; x=1688218197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0MHDOHZ+ksADoGSH1YMQnsp1jrJ4XOCHJuXFHrOLiU=;
        b=QWqVg5e1QFJaK+K8OgqKRRKFRfR43LBOZ4z0FQE1uCc4SdoEZfVTw7IhgxIXA8x/8n
         e13Hh7LUAIToB/eChVxW1hnb82oIbQmXrtuN+vu/8iQD1MzB67LxvzIlsPaXqkcPciCh
         utmxpRoIQFZj3lA8edYDlEGzZSoClEoh1/lOE7hT9ZHl/kqB9G22odigfAEu58l7Pvn8
         zDQ5JFPPoBdR2S5ZXtGFtZxYpenJc8mZhsj6q8FS2u3pnlGn3LRLHIs8FCzH7X5H3PqO
         wKX2h8ggwU4OY3q42kFv623MJVYldW96L+rm/JXt6XCpDQ0xrMTWN+dfbMHqB8A9n1d5
         buXA==
X-Gm-Message-State: AC+VfDw0ADCJ3FD+xqX3HOEQyWJS3Pz4KMlJrC7aNEE4S58FwsU050xu
        Nspgg3kaZ/0M/rz7OLCdP80XVTICCJDTPdUt+fy8VwjX
X-Google-Smtp-Source: ACHHUZ5Dy81eK4YJOMZQlqmsgjXuG6bCdbd4GPD3YQwxZAvKjgr/dStUZYO2WV25V3cnPKDK/O5vcg==
X-Received: by 2002:a17:907:72d6:b0:96f:45cd:6c21 with SMTP id du22-20020a17090772d600b0096f45cd6c21mr2973238ejc.30.1685626197510;
        Thu, 01 Jun 2023 06:29:57 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id k9-20020a17090666c900b0097073f1ed84sm10604629ejp.4.2023.06.01.06.29.56
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 06:29:57 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-30af56f5f52so793877f8f.1
        for <linux-arch@vger.kernel.org>; Thu, 01 Jun 2023 06:29:56 -0700 (PDT)
X-Received: by 2002:a17:907:2cc6:b0:973:fe5d:ef71 with SMTP id
 hg6-20020a1709072cc600b00973fe5def71mr4787778ejc.14.1685626175454; Thu, 01
 Jun 2023 06:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230531130833.635651916@infradead.org> <20230531132323.722039569@infradead.org>
 <70a69deb-7ad4-45b2-8e13-34955594a7ce@app.fastmail.com> <20230601101409.GS4253@hirez.programming.kicks-ass.net>
 <14c50e58-fecc-e96a-ee73-39ef4e4617c7@gmx.de>
In-Reply-To: <14c50e58-fecc-e96a-ee73-39ef4e4617c7@gmx.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Jun 2023 09:29:18 -0400
X-Gmail-Original-Message-ID: <CAHk-=whL65CLuy9D9gyO608acM5WLWo_ggAMP1cGu2XvyC0-hA@mail.gmail.com>
Message-ID: <CAHk-=whL65CLuy9D9gyO608acM5WLWo_ggAMP1cGu2XvyC0-hA@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] parisc/percpu: Work around the lack of __SIZEOF_INT128__
To:     Helge Deller <deller@gmx.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, dennis@kernel.org,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Heiko Carstens <hca@linux.ibm.com>, gor@linux.ibm.com,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        borntraeger@linux.ibm.com, Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        suravee.suthikulpanit@amd.com, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, iommu@lists.linux.dev,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-crypto@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org,
        John David Anglin <dave.anglin@bell.net>,
        Sam James <sam@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 1, 2023 at 6:32=E2=80=AFAM Helge Deller <deller@gmx.de> wrote:
>
> I don't think we need to care about gcc-10 on parisc.
> Debian and Gentoo are the only supported distributions, while Debian
> requires gcc-12 to build > 6.x kernels, and I assume Gentoo uses at least
> gcc-12 as well.
>
> So raising the gcc limit for parisc only (at least temporarily for now)
> should be fine and your workaround below wouldn't be necessary, right?

This absolutely sounds like the right option. Let's simplify the
problem space by just saying that parisc needs the newer compiler.

Right now we have that "minimum gcc version" in a somewhat annoying
place: it's in the ./scripts/min-tool-version.sh file as a shell
script.

I wonder if we could move the gcc minimum version check into the
Kconfig file instead, and make it easier to let architectures override
the minimum version.

I don't quite know how to do that sanely, though. I don't think we
have a sane way to error out at Kconfig time (except by forcing some
syntax error inside an 'if' statement or something horrendously hacky
like that).

Added Masahiro to the (already overlong) participants list.

                   Linus
