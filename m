Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F21C711186
	for <lists+linux-arch@lfdr.de>; Thu, 25 May 2023 19:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240476AbjEYRAi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 May 2023 13:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjEYRAg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2023 13:00:36 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE4A194;
        Thu, 25 May 2023 10:00:35 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-ba86ec8047bso1164565276.3;
        Thu, 25 May 2023 10:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685034035; x=1687626035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHrTsqL0nqeqxBvVw7n3mE3d9UFJpL2j8If6jZFByTc=;
        b=VEXX4D+/ehgygAWm5BmRxKMQVayX+huiD86BmHpUJbQZIavyZk8MqgFgBVJCgltW8G
         DGf1XLm8HhYD7C5Ltu5hncRV4xkFiRLvjnKAKUZAVqhHyZU7uDae6IK3C5qSD3GFgpGy
         OqLSmV63QlFHc9BLqOH+z3/46t/qsNvryv2gOmzRQJTarAzeFF3wkmaawd/u1vYzudf+
         2OoFyE7ArYkSpPwfiPG4wUCBT5egkmxxlXwXAVhzZYomT8xAIzGjfTrChNVAlbK2FaKO
         3t03QrSsNM3MzVGbAgb9jEqdKkZ/GGbY36ZIzPCKupNWpFQuCEQc+t41/FAd5d9jW5uu
         ry0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685034035; x=1687626035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHrTsqL0nqeqxBvVw7n3mE3d9UFJpL2j8If6jZFByTc=;
        b=RMzZUDsJuZLFwgNW98WpKtE0ELbyAiHu1ZKZKNTR0WmqNKZKoXvuKYpCk0sAd8GvrV
         tEVjLZNihwtsJ+7ELcn5/Wu7Z/OolSONBQfoJ7u7LFEU/MAHrbWrGxnpSWKDzwGwaHZF
         xZVQp0L1WW/rhxbN8mihO+t9VO4Sdd5gPaYY3iiy0jsbJc3ODwR1p4qL1+r9DfYE0vDg
         8JfEqi8GOlgYwmhHlIsEdsi6xnStaVP0X1QLzWNoxTKDiLFav7iIT382D0GIvKY7RwWN
         JKybNMvOdXyF5xgzbl7nuMqVlgFEe8LZUoz/cgYMYonpSrmYxzynYgCn0ui0ItvfGR05
         5/IQ==
X-Gm-Message-State: AC+VfDx8+JIBFKYl9eFzTAc5/+skqsZNO5jo7VisB7gsMRGosQzcvIvb
        9mgWXarQKat5ShyFN5Qo9hPWbhNEhfOoTFMT05y4MRzA
X-Google-Smtp-Source: ACHHUZ47ymCJWriUjad8DQ05hIMcCKin/PTMMU7nNv3HHwEyV9e0xB3DhHdcf1Fkkg8cgW7lAUtL7p6ayG4dp+Ur5MI=
X-Received: by 2002:a25:2487:0:b0:ba8:5ded:13f3 with SMTP id
 k129-20020a252487000000b00ba85ded13f3mr4152229ybk.17.1685034034679; Thu, 25
 May 2023 10:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230501192829.17086-1-vishal.moola@gmail.com>
 <20230501192829.17086-2-vishal.moola@gmail.com> <20230525085555.GV4967@kernel.org>
In-Reply-To: <20230525085555.GV4967@kernel.org>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Thu, 25 May 2023 10:00:23 -0700
Message-ID: <CAOzc2pxx489C26NnS9NHkUQY9PYiagzt-nYK6LnkJ1N3NYQWzg@mail.gmail.com>
Subject: Re: [PATCH v2 01/34] mm: Add PAGE_TYPE_OP folio functions
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 25, 2023 at 1:56=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> Hi,
>
> On Mon, May 01, 2023 at 12:27:56PM -0700, Vishal Moola (Oracle) wrote:
> > No folio equivalents for page type operations have been defined, so
> > define them for later folio conversions.
>
> Can you please elaborate why would we need folios for page table descript=
ors?

Thanks for the review!

These macros are for callers that care about the page type, i.e. Table and
Buddy. Aside from accounting for those cases, the page tables don't use fol=
ios.
These are more for the cleanliness of those callers.
