Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F193D55F4
	for <lists+linux-arch@lfdr.de>; Mon, 26 Jul 2021 10:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbhGZIPk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jul 2021 04:15:40 -0400
Received: from mout.gmx.net ([212.227.15.19]:52713 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232041AbhGZIPj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Jul 2021 04:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627289727;
        bh=WkWs2yjbuB7rMLWgvsxBc4/Z976NwWWIEDiSOgTN55I=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=E7jOP/dwH1+3UHoNaSbTx2XDQRxAN5F8L7jEpZmRIgESVf9ne0KM7xfW0ObhH8vkT
         ABXz8dsUiPiO1dwu3MUYUkMNesxVe0Yk5ji3YVzpNZGn/BfZ3uPtXbOes3Ed2hx1cN
         YAlh6MXWhHfFt0OlfJQAeFIRfElfQswmhjdssuBY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.59] ([92.116.128.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHG8g-1lugpy469A-00DFk8; Mon, 26
 Jul 2021 10:55:27 +0200
Subject: Re: [PATCH v3 9/9] asm-generic: reverse
 GENERIC_{STRNCPY_FROM,STRNLEN}_USER symbols
To:     Arnd Bergmann <arnd@kernel.org>, linux-arch@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Brian Cain <bcain@codeaurora.org>,
        Chris Zankel <chris@zankel.net>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jeff Dike <jdike@addtoit.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Richard Weinberger <richard@nod.at>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        uclinux-h8-devel@lists.sourceforge.jp
References: <20210722124814.778059-1-arnd@kernel.org>
 <20210722124814.778059-10-arnd@kernel.org>
From:   Helge Deller <deller@gmx.de>
Message-ID: <b89d9932-7498-edd2-0369-227ce17bcba6@gmx.de>
Date:   Mon, 26 Jul 2021 10:55:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210722124814.778059-10-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kdIeDnlaRuH2T6rYGVMcZI1y8GGtOS/nCSrzGPNZ3OUQY5MU47B
 5CBoPs+/Yybus1lp3BFr1TFHG7JdG2o5Hk/+MOXzTPoZvzj/YZ/cz0YWZjRIVcPlnwe88YM
 WDlT2nlwI7uszkXCcyqKqCixlXZhA3YZdT580q2WrQJMaYRDbQNCq2HCRZf0EsBm4LR75i3
 BHhYUoKB70JevsBXEfP+w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:t7OOfsjhfdM=:cPmtJv3NWFJm9d/RuoNb+/
 Ou4Bbj6nA8Q23PNuEt+UCFyyraXkWNdlDMwrkBg6/uFHrFY5gewiHslDKOPvwvPZ4QoBcNuDT
 8bh8p1CqRqBNHsASvkEW+aJWm7j9TC8kTFOu4TqiRXvTqGCDIZxCBbYk3f4lF/KmzuVlpr0Du
 E6C7Nzp0ITty3fkhOUAZ7wUXr3fIAjaxGFOEos4Wax/D/96hS2a6wrxxpOtPW0jHf8YZSnTSW
 +ywaHc1qBSckC2nArgXnml3LmH/tsv8FS8c8fz5NB7haNTuVB2mlV0T1Vj4jUSZlFG40Gwuh+
 Qrs/0c1D57oh8kEVO16Yxgp9ls6PVKeBRbaiSNH6omxp9zKHT1mUSR523x7yUMgOqnIwFCvQm
 Me+mKB5Jup/it+POvsUV+NExWuf1EU1Q6I3aIWzXucxBkrfZ8sNKgj9/ZrGi4s5deIMCkm4jD
 WaWwGwylSRBIWBpcPDH0v0u+AcyK6mHWrvLsuJgLfVQZ5MtFihjQ7IUGh9k2b0pB61aSNX6Ja
 aUKIE1tfVrDqxg6QPCBlKIYbOglFx3Of70KtfGF8Y17PfXUSYPqmIeU6f6rsvThB99NrFTtHg
 UuNp7rNTATgACIDJvcPung6RI/RTVo7xMb5KnslJrTw9tyOlK9c2QiI4u0GzBTGGhI8sB+xEQ
 jccA0NGTg7ONUDj1qS8/RGqjPZqiAucjd60cgrD9OBfKsNeFwDYDDjlfg22beeNTYtcRRGsU/
 cwWoNxvInEN7Q5ES0wOBjYvb7zo04AJRFD5+mjf/YJhtmoSZpHSjHRKmLuE8O3jTocx33DzoS
 l3W3ypaoWe9H/E/AKrwcePngCJNADVH5MLl1qd1trF5lrhH1mRqrIzmYoSrFiehrBph0pN1BH
 etTVyfghR0rL7vavgTnKsreSpMyl3W3flVYYrL1VFrOZOaFlu4o/STXYiDOLTuais8R4uHZ9m
 rx7BDIdUVUu2cfGdCxzn72+/DIL+wTIkX3hYLkdhLbb0ILsnNCRr3C7E2s1DdY1NyblFsxj3/
 LgqPcJqCPQLSSnri/QeHDporOJ+A2BTzG1/uoMuWJameE3z/JlSz+68zDXDri1c2g98Ia8/zM
 mym0OeKhYLafNgyhfcmFszob94nhnmC8BqG
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/22/21 2:48 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Most architectures do not need a custom implementation, and in most
> cases the generic implementation is preferred, so change the polariy
> on these Kconfig symbols to require architectures to select them when
> they provide their own version.
>
> The new name is CONFIG_ARCH_HAS_{STRNCPY_FROM,STRNLEN}_USER.
>
> The remaining architectures at the moment are: ia64, mips, parisc,
> s390, um and xtensa. We should probably convert these as well, but
> I was not sure how far to take this series.

Acked-by: Helge Deller <deller@gmx.de> # parisc

Thanks!
Helge
