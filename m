Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBE90EB17A
	for <lists+linux-arch@lfdr.de>; Thu, 31 Oct 2019 14:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfJaNrE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 31 Oct 2019 09:47:04 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:51615 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbfJaNrE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 31 Oct 2019 09:47:04 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MY5XR-1iTfHn251x-00YO30; Thu, 31 Oct 2019 14:47:02 +0100
Received: by mail-qk1-f179.google.com with SMTP id m4so7025100qke.9;
        Thu, 31 Oct 2019 06:47:02 -0700 (PDT)
X-Gm-Message-State: APjAAAU6PeP9agN7/anhlm5j4iLIWr18mL9ZZSSTiwGWKlT5gotlXw0G
        bjeIJp1VUpPLLjGREFwaECh/eSQSoJForsGx0UQ=
X-Google-Smtp-Source: APXvYqwYoQTEthtnSTVFwt/kx2esJ5/VAbLAMZ9ee49FdSHuytOsmyxwwNYKV3cufux6mKtj2roQiWuAZmQk9D9c/Io=
X-Received: by 2002:a37:4f0a:: with SMTP id d10mr586266qkb.286.1572529621308;
 Thu, 31 Oct 2019 06:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191031003154.21969-1-linux@rasmusvillemoes.dk> <04799503-b423-6bc8-71cd-bee54e45883e@rasmusvillemoes.dk>
In-Reply-To: <04799503-b423-6bc8-71cd-bee54e45883e@rasmusvillemoes.dk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 31 Oct 2019 14:46:41 +0100
X-Gmail-Original-Message-ID: <CAK8P3a17NbSuWzvjKSJiUkxPLhKbqnAEzJLBKuHkPGGjDA6QtQ@mail.gmail.com>
Message-ID: <CAK8P3a17NbSuWzvjKSJiUkxPLhKbqnAEzJLBKuHkPGGjDA6QtQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] powerpc: make iowrite32be etc. inline
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:mHUdX1ZTCd4q6WBqCcgL4S6XxArpQsw6z1YowM0PkBXHFEHy/QX
 joV9mwTKo/tZbs6eQ0YeXj0GXEH8RynAzN1SMN1WMVzVeA8FMbiJotNEwvh73AD9LcP53wh
 eIWA5JBDUQWBF9Bdon9zFjoyY71b3jLVFsacwlHJR345EptVAuS50Sz/7Bx8jRynEMZRHzx
 qrJU/xKsoied4iZXomdUA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cz6l7kZIsvA=:eKgx9G8HquZtQ8jWbhW2e5
 cwifKxrl5vQBpPy3WeZCUnV9h0dVY+9eC+w4t4JKcNkPtyFjwTN1sw1o7r+Bub2A+BvjkzBNb
 D6+4xVDgOHmbLMDErodIfF8CJZi5Pzqnm7c2drK+EOEh63/TdkqSwNbhC34lDt6DmZL7RTG1F
 OTq/Jxxv382tkcDkhR8yl7ZumqIJQQOqsZFPkrF22iI8opr6Dcv1h9UbXHWdNa0bpOKa7JMW9
 8XOl+Baj6rP3wKbtpJoNkFzIBrM9QmK27WBCw6aAJo2mGcbdXhXo3/9iUBfeMrpes5+at5nkH
 j3BjlgJRZn6jLERQxhT6tlm90PeXDvizIZNqHq61rUHWxD2fW+BZwVbzdctY9rhnumLYZ1wEq
 9Mr6dIXicefuANMXxQpgqpnTmMbvqyLr/6CTOiTz6GlKZQL/4i+bMJMg18WICyJCtF2gbVvIb
 gXv3OHbjsNI+gOOXOeYDppOTwPf7HreOYwZ70rb+ocXCpQIhb/jA5yvkeSkzxY2X/bP0N+HO/
 LLCcpc2Xqc+34Un6aOvGtwX10u0RyYUfAn8PXfx9ZFYIB/CXTU6pq1OVEyfJ3LPHndx7uV9vo
 YxULOYqlHm0YpAB1q3mTbJd/SQCCv1LI3ZtciYm2zM+oBKrrFR9I5cSua3aSI4qDUzEu/jGva
 NQe5/Ib2PLl5ZYogKhh+c7j1sQwZFhdezKirLyEnak1DZXPJA3+3pEoXDAs3A1vz9f2WTATNn
 neGr8+vjnufMBg9LD3Hc4YT2zYsM/oXdPILVnnKq7Q/PjF8igIecNboG4NJ8dzbGgSHQGCdjR
 bu4BeutPTFOmirac8KuHNN4VDOIFerbsHPqcfu5EU3duEIJMLXg5VkBwtgj5oAeUFfjAQoaGd
 X0KSpH9EceFpi07bj+lg==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 31, 2019 at 8:39 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
> On 31/10/2019 01.31, Rasmus Villemoes wrote:
>
> So sorry for the noise. Maybe I'll just have to bite the bullet and
> introduce private qe_iowrite32be etc. and define them based on $ARCH.
> Any better ideas would be much appreciated.

We use that approach in a number of drivers already, I think it's ok to add it
to another driver. Just make the powerpc case use out_be32 and everything
else use iowrite32_be. You may also be able to enable the driver for
CONFIG_COMPILE_TEST after that.

     Arnd
