Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E92740265
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 19:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjF0RmV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jun 2023 13:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjF0RmU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jun 2023 13:42:20 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DAA1A4;
        Tue, 27 Jun 2023 10:42:19 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5701e8f2b79so52317477b3.0;
        Tue, 27 Jun 2023 10:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687887739; x=1690479739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i618d6TBDc9eRPjFDJkpeqKfOfbO3uM7uCEV9XLltFk=;
        b=HvOjTHjCD8itMm1xp5AnK/TmYH5tQiF1El2gyMO5zpqTY4wM1G2ir3ku6089UY1inQ
         ilXwuLjIDRYIMPHiQPHPbFQRy/hIa9oVwH0QYqAm53mZsyIpL6HgYzNNL/NNLIh2SC53
         /Joi55NqQPacIQIaSPLnjCH7o6qvV31ICWbCQ8IiY+RsTUhqfYiVoVRzcNBSzvMpURs/
         f/RKmZePqghHrHdV5n1so0lsBS2EaZX77ICe7eDI+jllhbMiPBHJhxnD9h+Hh+PnGjAo
         7epexu03a+N5aJGPnt128CQw+E8IVZS3OeUo6R0hlPLkskRaMfOu6WUJJOIpsapTfYI9
         tHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687887739; x=1690479739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i618d6TBDc9eRPjFDJkpeqKfOfbO3uM7uCEV9XLltFk=;
        b=bJvt0YQBNpk3PZs3ijuUKlNh0/RF7UFpJ7pf9fbSjBvZ+lB5qsiF9O+uNfKJMc+Y8D
         YHmXeH5VrGR7CyW0NrGK+UepzGo6mFlK+7jOcOZwdcuZpQC78NuK/ukis0WoiLZRwBZZ
         CdB7Jn8yaStGuFvB2FIFvAnD3UExbaqRp/2Q+891UQYyL9MFTop4pRslECaFjLFTQopE
         wcPlg5A44+CbwhzHJ8cA28SSESgnVyPEylPa2ihSdHd1vToDopJCbpXx4mXJjeaij0bc
         pOx/NCCaPG5AqFGi4rH6a+3c6ARmIE/SZtIbM0MO1pvjQJDI6T4plTcikP1THoTE3asB
         e36Q==
X-Gm-Message-State: AC+VfDzBVvFyAX9JfOHwJ7TQUg3H+uGzobhJS2YmaaH/LLCt0qROQB0Q
        u8yIXs4AwvjdfvbcdMmEYarcF8Oj35+MWxeBDCfCJAqywmU=
X-Google-Smtp-Source: ACHHUZ5ixDfcfZvsP+Sk9Q2uIR96dLCuXZPewVmRsckC25R1Wt8J/1BC8EjmOgQOvqL4+PjmfxQNP2ok9/vuUSXcV8M=
X-Received: by 2002:a25:86c8:0:b0:c16:ba32:1b1c with SMTP id
 y8-20020a2586c8000000b00c16ba321b1cmr8446597ybm.58.1687887738923; Tue, 27 Jun
 2023 10:42:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230622205745.79707-1-vishal.moola@gmail.com>
 <20230622205745.79707-27-vishal.moola@gmail.com> <13bab37c-0f0a-431a-8b67-4379bf4dc541@roeck-us.net>
In-Reply-To: <13bab37c-0f0a-431a-8b67-4379bf4dc541@roeck-us.net>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Tue, 27 Jun 2023 10:42:07 -0700
Message-ID: <CAOzc2px6VutRkMUTn+M5LFLf1YbRVZFgJ=q7StaApwYRxUWqQA@mail.gmail.com>
Subject: Re: [PATCH v5 26/33] nios2: Convert __pte_free_tlb() to use ptdescs
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 26, 2023 at 10:47=E2=80=AFPM Guenter Roeck <linux@roeck-us.net>=
 wrote:
>
> On Thu, Jun 22, 2023 at 01:57:38PM -0700, Vishal Moola (Oracle) wrote:
> > Part of the conversions to replace pgtable constructor/destructors with
> > ptdesc equivalents.
> >
> > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
>
> This patch causes all nios2 builds to fail.

It looks like you tried to apply this patch on its own. This patch depends
on patches 01-12 of this patchset to compile properly. I've cross-compiled
this architecture and it worked, but let me know if something fails
when its applied on top of those patches (or the rest of the patchset).
