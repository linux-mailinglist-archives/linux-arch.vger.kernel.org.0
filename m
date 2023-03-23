Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C267B6C7055
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 19:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjCWShi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Mar 2023 14:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjCWShh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 14:37:37 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1B619F12
        for <linux-arch@vger.kernel.org>; Thu, 23 Mar 2023 11:37:36 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id c19so27683668qtn.13
        for <linux-arch@vger.kernel.org>; Thu, 23 Mar 2023 11:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1679596655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbRJPS/v8/2yp+Yuy7Nlcd2zcwyezFJR04VBr9Hh16c=;
        b=fw8O2F6Uczyucy9+5FNKoD4fblHBvwXyeAYBq0UqCYAB9WztSy9Uz/VWXuZ1/o/Udt
         xKbVYrVnTdNdsi8h2wVgeYNkXCSr7E71emTH4EegG6M1NV3vAZz3zO5jh+zf8wuXi/xX
         vnXX5EFeHX4mKSz0QL8a5VY/fYV3qXw2jWBu0pDT5erVfOshtk/WQQxEGuMTI0CDdiN/
         SKpaNEHr2twiIBLVH6Wsy+oKXHYdQBJblAi4bfwycHj9FWyHQokvRFosPlg05D4JU8A2
         +n/rH3+Ouc57dC7KPQdbQ3YrTDh9zNH93vbWbL/33Wa+VX+iKoU6gxALKcn2p3zcsneJ
         Pd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679596655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XbRJPS/v8/2yp+Yuy7Nlcd2zcwyezFJR04VBr9Hh16c=;
        b=nHkhQuO2gl9fcNn2NO2YDu2AQ2iVcanpcx0BO5ekIP4G1wawG73NfCd38Y6knr5QbC
         Uzifa6lLf6WP+uxfg9UucluohacSs05O7Vyo2SIjGb0qJuLn3+EQ9TK0afSOsnK1ZVGq
         FnjCdd9xrUQ+TyR3f6/5dihuzIccRpHY3fBrAFAbYYh3UxRNce5Brxz0HCwJWsLSxjSy
         9NJQFsPuRo6GsBF+BCORT8Ks4Wa2t+SH/izRfRw7EasvxuGSqvlG+g0uQM6XPZ+gpUj2
         Da5J01jllGPvPffu4Qr8cwIBWFBbAnV5xSqwte4eYOTO1aQvCRNeTjFuX+VKrLingbfT
         pjug==
X-Gm-Message-State: AO0yUKUNswSiUi9GyCIFWivsPsLaF0zJvwU1DMh8qi5eqjyntXWVMoJA
        GW6m63gW1zh3G1Dvx3ntydHXVkBW+uZ5HeAyHWtb+5KPbfvK7+r2t9U=
X-Google-Smtp-Source: AK7set9PBf2gqbX+dZtVGyurSRrdxxPqbcUa0IJaTtOpaDUBKo5pZTjqrQwh/NWyAHLPrSspo4A1UsuFDpdNqZPlSZE=
X-Received: by 2002:a05:622a:1a02:b0:3e3:f70f:fb13 with SMTP id
 f2-20020a05622a1a0200b003e3f70ffb13mr142785qtb.6.1679596655348; Thu, 23 Mar
 2023 11:37:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230315051444.3229621-1-willy@infradead.org> <20230315051444.3229621-2-willy@infradead.org>
In-Reply-To: <20230315051444.3229621-2-willy@infradead.org>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 23 Mar 2023 14:36:58 -0400
Message-ID: <CA+CK2bCzC8U_Fu-iwWuodHRaYYAhxRPk79cHoY_3ajAw=zWdTA@mail.gmail.com>
Subject: Re: [PATCH v4 01/36] mm: Convert page_table_check_pte_set() to page_table_check_ptes_set()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 15, 2023 at 1:15=E2=80=AFAM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> Tell the page table check how many PTEs & PFNs we want it to check.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Thanks,
Pasha
