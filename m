Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2101259A97
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 18:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732386AbgIAQvi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 12:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732269AbgIAQvg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 12:51:36 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25A0C061244;
        Tue,  1 Sep 2020 09:51:35 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id h4so2682818ejj.0;
        Tue, 01 Sep 2020 09:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7wmhqZFH/qn9LDILgIA8ChHwbJC43R72DMR15uZTThk=;
        b=sEZr7yNRdN4XLqfS6kDyAxYMdSBUX91Lrvi8DIlpUfVVpd3J5MGuriq05qiGIsFfOS
         1nG7p40rnY/7KgeLHd2mSz2SaSPiph2LzX2zQveYL+gCSwfsUOJ91ylYKxowQstupoHr
         rTphTq7xjbalXBUO2YQtmYt1+/rlilxOjz44ZxPiHsE/E9HlrOzR3z8qcqtpWuQYlS6f
         C72bqQSR5JUMMlaYJCm9P0yK2PoKq9jpweruEfjJfyxZs3Q7AjjqPIpWmXwmsvQVaqwi
         xUReZMYW49QhZObiQuohBS57V2gw1dNeD/DJGMAANfTuhSdeg5KqD3YcCm0fRUMMsosd
         DJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7wmhqZFH/qn9LDILgIA8ChHwbJC43R72DMR15uZTThk=;
        b=rGbtnm5wyev0yrompjZ4mcQjoJsY07xpAea3aB7QE+8Px9mmWL0Vc2tgtFiSMIJrkx
         oR1rWLcUlhCVuzzGxD8d93sK6SPJzrZ00uh5BCDE/tIX5H+PaUC5C50iqbT94X5ynW7v
         ix4bWOzkqjPf4F3yY8gN7bV60Vadj2+q2gvJZg5XVOfb8rFYqfYZexIHAMJ5vrtEmIYA
         rMthkCD3M6hEj86ZqYuUe4WYgsB0byqHw8a9/cVn6mjH7jZiDP3SNljiA6BLpUFDUPd9
         6X/qlYuuYCKLFJIccwP42Ox7w/FueX6CZUcIPumsjJBPSAIF71ZigOM75ONF3BlOgxmp
         5VdA==
X-Gm-Message-State: AOAM531DKTgthJFXt6EqgWRlQVzyrTi5bwOLUK+b9DOscQ4O7tQ2n4QP
        RTGALpYbJ+LiiMeCU/DDnTHUGaY7P4Q5S09Gkgx13T9veaU=
X-Google-Smtp-Source: ABdhPJyfEptOql4F89GlhX35Na6O9a4L6VSc/7rNTm6swT5iiAwRTcUEckrtJm7Tp6jErL0lAjQgG7Kb0J2UsEAk9/w=
X-Received: by 2002:a17:907:264c:: with SMTP id ar12mr2444569ejc.80.1598979094509;
 Tue, 01 Sep 2020 09:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200901141539.1757549-1-npiggin@gmail.com> <20200901141539.1757549-3-npiggin@gmail.com>
In-Reply-To: <20200901141539.1757549-3-npiggin@gmail.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Tue, 1 Sep 2020 09:51:22 -0700
Message-ID: <CAEdQ38Em+s7e50Z+z+frwT8xHc=cHG70rjSmAPo+9RmJcCwTGw@mail.gmail.com>
Subject: Re: [PATCH v3 02/23] alpha: use asm-generic/mmu_context.h for no-op implementations
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-alpha <linux-alpha@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 1, 2020 at 7:15 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: linux-alpha@vger.kernel.org
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>
> Please ack or nack if you object to this being mered via
> Arnd's tree.

That would be great.

Acked-by: Matt Turner <mattst88@gmail.com>
