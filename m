Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BCD253520
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 18:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgHZQnZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 12:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgHZQnO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 12:43:14 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA01C061574;
        Wed, 26 Aug 2020 09:43:08 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a26so3791056ejc.2;
        Wed, 26 Aug 2020 09:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qkFKNXoEvLaLjtg+VSz16h2fveq81SS9ALzUgSNtgqs=;
        b=CakgDGbRZTzTHaByk+lLgKHAFfB0XFPxYb9/t80ox0YhHH6u4XkpStD+n9gvJwp9JU
         VtqToaWErw3FJC5UxOOpsUCF16upp6oUyIAFWdDggM7wTBxaiX1QV+qpZxJLV45hNDxC
         ayAhXmZ6ca7mOKsEwullJQ/liwoiVexsABkb4fhgdWMsCMdkkoov3yrdFEjoelWh2evY
         fIzqGDHTHD2AbVrW30YWvblbDe05bXcj6o6ddg0Bx3HxeYynyXQ8MvIkdkiuSHM6GDff
         0F7pwhT+7dkEWxpHRS6yLOP1JQ5RfpmEenZp48bc5QtfWss9mCqpr/uGMTNOm/xkRg3O
         jijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qkFKNXoEvLaLjtg+VSz16h2fveq81SS9ALzUgSNtgqs=;
        b=s1d67bXwXfzoE7w7V46RRbgq2v0bYkIv1WWUqjqDPr/QiMq8CRfqDqx3UKYrX6McSj
         WW/OzYVxGcvcUTsIJhGGC/Y8Y6htNHblu/r8FY7Ut/U2xgT7PAgBw4kN9RbknqJssWWL
         k0w3Ch/vCCjnkrfThbbhIk1I8vtVvPsGQ6a+o6xHASzBVKAp/XetMXmb93btaybMzfLd
         n8Y6iV1gn9bY4hUWvfwej6c9ayki4iTOswwGZ76ZG1XzYJiCq+ag/r0luB/GpAGrUlCJ
         /ELN/sBwN6O+7G3vi8cH7CabVolP50XS5pUAaytW1als31QUOiRrq7z1LAvEX0CRGRCn
         F28w==
X-Gm-Message-State: AOAM5325euW2BwTDfxtdV436ejVLjtIougEq9qyL7bbL4aXckDkj4lrN
        L7rMugrsQbrkfrHJah7eVOdctMCYyH/kU2o8GU4=
X-Google-Smtp-Source: ABdhPJzSJAHgQkmx8WGIzyyLafbpaY1jDCkkSspzLKWqPbii9E6oNzLepZsKGVV6GZz8L/MNYEUf9aWeQHpJYteEUfs=
X-Received: by 2002:a17:907:7094:: with SMTP id yj20mr16281482ejb.471.1598460187197;
 Wed, 26 Aug 2020 09:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200826145249.745432-1-npiggin@gmail.com> <20200826145249.745432-18-npiggin@gmail.com>
In-Reply-To: <20200826145249.745432-18-npiggin@gmail.com>
From:   Pekka Enberg <penberg@gmail.com>
Date:   Wed, 26 Aug 2020 19:42:50 +0300
Message-ID: <CAOJsxLFoX5rk+k5GASBh5vxL-Vfj7OkD_UE3p=_cS3SwhBVEaQ@mail.gmail.com>
Subject: Re: [PATCH v2 17/23] riscv: use asm-generic/mmu_context.h for no-op implementations
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     "list@ebiederm.org:DOCUMENTATION <linux-doc@vger.kernel.org>,
        list@ebiederm.org:MEMORY MANAGEMENT <linux-mm@kvack.org>," 
        <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 26, 2020 at 5:54 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: linux-riscv@lists.infradead.org
> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Pekka Enberg <penberg@kernel.or>
