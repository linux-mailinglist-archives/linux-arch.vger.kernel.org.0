Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453272789CA
	for <lists+linux-arch@lfdr.de>; Fri, 25 Sep 2020 15:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgIYNkZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Sep 2020 09:40:25 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:38487 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgIYNkZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 25 Sep 2020 09:40:25 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MC3L9-1k9PMr07Gn-00CRU1; Fri, 25 Sep 2020 15:40:24 +0200
Received: by mail-qk1-f169.google.com with SMTP id w12so2764989qki.6;
        Fri, 25 Sep 2020 06:40:23 -0700 (PDT)
X-Gm-Message-State: AOAM530500acsNwYCXug3/z+Zgh9+yPg2H/ioFdnWAyRBY4V5WQErZzU
        HEqRXjSJK8zb36/LNeaKAIwQPmQnzCkjDKH9yto=
X-Google-Smtp-Source: ABdhPJxIzKAUN9mD09+7O4OymSuZ1I/pDmcOEjpPUHVj02syVVQTEeh8QmLOAxe8V/n/N1LP9j4emlnxenewjYHzGJQ=
X-Received: by 2002:a05:620a:15a7:: with SMTP id f7mr12935qkk.3.1601041222779;
 Fri, 25 Sep 2020 06:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200918124624.1469673-1-arnd@arndb.de> <20200919052715.GF30063@infradead.org>
In-Reply-To: <20200919052715.GF30063@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 25 Sep 2020 15:40:06 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1LM8SXbzcVv1B05fdmxBZ-PA+P4m4oP1Dgc4JmR2CGMw@mail.gmail.com>
Message-ID: <CAK8P3a1LM8SXbzcVv1B05fdmxBZ-PA+P4m4oP1Dgc4JmR2CGMw@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] ARM: remove set_fs callers and implementation
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:3NzBN9prIQYrQLxyTiAZ2qekukyha8zMOOKFTefaoN8A4cWDskU
 LvRVk2YSWJUK5ahJIHR2B7rnCU78KMisNA1U+rTagdpd9peGNaqHqHCkRwRwpCiJ9Tci10m
 2CRQfikVzGKPTSxf+u+NGDRgVrFHdEt7bDNkLHdNPM0W26v4+rNQADfIdn5u2RJ7azhmXrV
 wKtVOCtdXtquaSPB7JA1A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:b5RuZM+XTM4=:RUDc48Wx0DH6fMnrXUFe53
 Ifc4CzYsoWg2OCRivZd71czdBfbSdMsmpym9w7syzpV8JDeSv7YPHoJPuRSoooeRcqzRZmDDq
 6VqdAdXExajOI7565jIWc+DsLUHMzF8IYzAHzfnZqB/p7ksIlMtya6ne2/Z9m0cMFbEmgZudZ
 LfWJ6CQmpu4B7oycrYF7UVue1z5Ztknl+96h1kD5UiTPNF0cq4qVagSyHzGwvLQuO9P5nzwtO
 9K1wpu1qpvhu2xyQTVcHb9Q2oLSwJR1SNfs6zOTh0TfiLOAspmIXiqEzTq+TEcXnQzUNFRPyc
 CexaTEiyWUx7SFKYQcCV28/jEvTYm150H1P85aaB5K8Xgqos6tyyie887c6Usn9JtWG+/egLS
 lBdmSx1PF/wD30yUiDFWo8nXH1EBKMPL9rGRxusPKCRvL7mkFdbmnbfBmBhER3ZIv9/cntzai
 w33xWqzK9PM9ZPitW3TbgHhu6WlV5ow4CYvuFoSmU1YcwSrFvDZPuvrH5ovCyxmRf5nuAqiud
 PovdlNefEjsWbmJRUL626Jkkv3H73zELEzk1hJP6ETDYHNdZyppYgFTAVN0BK/9ACLMZAE2uU
 5lXm1FrqkAczFZSLlUjm6byvUQmAb8aEe4lIp5OAb05+HkW9G+QX2RETs4XGmwiAHzNkPhYdc
 t7TKenHf63/bmC+w2OsVu6/toOLXrQs5o/tQ6/h6frZ1ikZdEW4OmtB6SF1k25P60Q0aqUN2w
 QSP6S9SYYyJkJlQELTJBGw2AYdSETNJOZDzLFreXzyNPCCg8RLInGZ68qmF1vCNV1BOTO5RMN
 dufYlE9dZiNsN6lmtdAFOIgJfdUMNL6UqwqNdZea5WIkly7Dj1+uQFn9ux++y2EPFU4nMMu
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 19, 2020 at 7:27 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Sep 18, 2020 at 02:46:15PM +0200, Arnd Bergmann wrote:
> > Hi Christoph, Russell,
> >
> > Here is an updated series for removing set_fs() from arch/arm,
> > based on the previous feedback.
> >
> > I have tested the oabi-compat changes using the LTP tests for the three
> > modified syscalls using an Armv7 kernel and a Debian 5 OABI user space,
> > and I have lightly tested the get_kernel_nofault infrastructure by
> > loading the test_lockup.ko module after setting CONFIG_DEBUG_SPINLOCK.
>
> What is the base line?  Just the base.set_fs branch in Als tree, or do
> you need anything from my RISC-V series?

I imported these additional patches from you:

e0d17576790e quota: simplify the quotactl compat handling
b0f8a0c4046f compat: add a compat_need_64bit_alignment_fixup() helper
ed8af9335e19 compat: lift compat_s64 and compat_u64 to <asm-generic/compat.h>
ce526c75bbe2 uaccess: provide a generic TASK_SIZE_MAX definition

I think I only actually needed the last one of those for the Arm
patches, the other ones are dependencies for my other patches
I have on the same branch.

      Arnd
