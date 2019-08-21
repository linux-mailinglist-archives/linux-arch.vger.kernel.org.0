Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71CDA97076
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2019 05:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfHUDoG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Aug 2019 23:44:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfHUDoG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Aug 2019 23:44:06 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05C472339D;
        Wed, 21 Aug 2019 03:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566359045;
        bh=e+udB4TYXvsMi0hTFByO/ay1rH0jXDaWG0BbJiMiN1Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C3jmVY+VZ0ygV2erjDtzMpbnCvvJhShU5/ec8pjgMv5skLf9+RGMZZ2nIGfR5367J
         dyixNo+FrVDIIw6r3JgyB/Bhy9qUhqku/hu0d9en2Dx2BVXevucNq+jVr5uJEo5iBF
         EJCFi4fqvtLlCZ7wS5iTN3deAUaZppsUnRYAr93w=
Received: by mail-wm1-f51.google.com with SMTP id p74so595370wme.4;
        Tue, 20 Aug 2019 20:44:04 -0700 (PDT)
X-Gm-Message-State: APjAAAVFvl2OyhXS3q93RyaWRDljhI/xTbPNlb8GGfCx+ea72VGaErVy
        z93FUz9hKWET4tGIdio6+Pp7+vV0Ewu0diWQAGA=
X-Google-Smtp-Source: APXvYqynv3MVrJSpaMJiOrvq86YRSwCyEIQy7tNYbAfM0k1dovwvMGb9A+qh6CJH0wLsekBE1vCnLmOEEzvjtF103eI=
X-Received: by 2002:a1c:a5c2:: with SMTP id o185mr3158973wme.172.1566359043451;
 Tue, 20 Aug 2019 20:44:03 -0700 (PDT)
MIME-Version: 1.0
References: <1566304469-5601-1-git-send-email-guoren@kernel.org>
 <1566304469-5601-3-git-send-email-guoren@kernel.org> <20190821021741.GB32710@infradead.org>
In-Reply-To: <20190821021741.GB32710@infradead.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 21 Aug 2019 11:43:51 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSXZB4r6_BdNZ+8p_Z2A-AVLyz00o2qdRUMjzZ3b7z6iA@mail.gmail.com>
Message-ID: <CAJF2gTSXZB4r6_BdNZ+8p_Z2A-AVLyz00o2qdRUMjzZ3b7z6iA@mail.gmail.com>
Subject: Re: [PATCH 3/3] csky: Support kernel non-aligned access
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-csky@vger.kernel.org, douzhk@nationalchip.com,
        Guo Ren <ren_guo@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thx Christoph

On Wed, Aug 21, 2019 at 10:17 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Aug 20, 2019 at 08:34:29PM +0800, guoren@kernel.org wrote:
> > From: Guo Ren <ren_guo@c-sky.com>
> >
> > We prohibit non-aligned access in kernel mode, but some special NIC
> > driver needs to support kernel-state unaligned access. For example,
> > when the bus does not support unaligned access, IP header parsing
> > will cause non-aligned access and driver does not recopy the skb
> > buffer to dma for performance reasons.
> >
> > Added kernel_enable & user_enable to control unaligned access and
> > added kernel_count  & user_count for statistical unaligned access.
>
> If the NIC drivers requires this it is buggy.
Yes, you are right, but I've no control on their non-upstreamed
drivers. Every time kernel version updated I need to take care of that
issue for them. So just give them a back door in arch/csky and they
could disable it by manual.

> Kernel code must
> use the get_unaligned* / put_unaligned* helpers for that.
Most of ethernet drivers use netdev_alloc_skb_ip_align() to let
hardware deal with unaligned access,
but some NICs couldn't and we may modify kernel's skb_ip_header
parsing code with get_unaligned*/put_unaligned* ?

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
