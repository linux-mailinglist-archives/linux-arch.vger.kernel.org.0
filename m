Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8F13067A2
	for <lists+linux-arch@lfdr.de>; Thu, 28 Jan 2021 00:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbhA0XQO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Jan 2021 18:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235328AbhA0XMF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Jan 2021 18:12:05 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0930C06174A
        for <linux-arch@vger.kernel.org>; Wed, 27 Jan 2021 15:11:11 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id dj23so4439835edb.13
        for <linux-arch@vger.kernel.org>; Wed, 27 Jan 2021 15:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=P4E9XkSKWUJdsiYmpjHKs1qxutdDmK6RKi7DGMsqnfo=;
        b=Q2jkOledYj90UawG6DC1dSHDZAGnp9L6DRQjK1D66cAkvwO6hk8Xsthr7hqEG7jueZ
         yLBGLtdTjXbY4Zjya6m4NQBwZtczDulMvssVO+laJZt1eWI07XllWSnP1EdmbRKwwvh6
         gDymjd48Dx3Egm/G2yK/IswQSAYCyEHvEkLdZuZrbR5Kr0prZweJoS2W2u6tKhLjfA0d
         LzYTShcFm6mXtyyKuOiiCWOIqv7+lsW9/KjBYgUtoF32rut5vFG00NyZIGrdS0AwtcpR
         5N2pBfKtF6WYksAgOtvJa7U8Nn7dzehnAxp8Zcnx5p2LfR5oHqRjx7NLpk429kaj/mdW
         PksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=P4E9XkSKWUJdsiYmpjHKs1qxutdDmK6RKi7DGMsqnfo=;
        b=X3yyNifYt+N0VM4UQHTMHGQWgWbKnhOPUu2wAM5n3xW1b7+CD0Z+ms3TBEZM55U/KC
         kVS8aOfH4BLXU9E4puL065BXCoxWr7fgaAYql4Pq/fz0JOPLkiunP0zLFzPv5+tIaMc5
         gv6drxG5rsMvGxjT5jEz2T7CT1jR8TUeNBt8/JamXYVCiYdQ+3/mVKL7eXKvrY5SQA6K
         Hk7baUNAfFIj86JbZqgR74w0jFvWT3Jv76Gx+4GGUStdHOPnkjbIDJOTNWl5qf2Zyerq
         d3MH3GpzayhzCD+CD5YeKzakql3Q9zXn6kUf0bD0Hunp7Ee0f4gZCmsPS9J1YFio9xga
         5zsg==
X-Gm-Message-State: AOAM533kdijdfVu92kCUv+SsGpCSaJO2WvC5wrY1LKxqeRivvioG2syw
        TwTYAHL1AtlWblu5yqtTwzhiw+EMFQCOpRELQylptQ==
X-Google-Smtp-Source: ABdhPJwZ05CRYzyDCIn0+aFVtJGEaG/UnKXK3voTOj0Ndco5CXyd3muvzdlRYeyyYdJ8Cn8ILMSQUOEfipZHhI1dia4=
X-Received: by 2002:a05:6402:1341:: with SMTP id y1mr11078032edw.273.1611789070344;
 Wed, 27 Jan 2021 15:11:10 -0800 (PST)
MIME-Version: 1.0
From:   Kyle Huey <me@kylehuey.com>
Date:   Wed, 27 Jan 2021 15:10:59 -0800
Message-ID: <CAP045Arw973KWCiHqXmRJ3QxH8o84on-t8Nm6NyEYXDpicF7JA@mail.gmail.com>
Subject: Re: [PATCH] ptrace: restore the previous single step reporting behavior
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     kernel@collabora.com, krisman@collabora.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        yshuiv7@gmail.com, "Robert O'Callahan" <rocallahan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hey everyone,

This regression[0] has totally broken rr on 5.11. Could we get someone
to look at and merge Yuxuan's patch here?

- Kyle

[0] https://github.com/rr-debugger/rr/issues/2793
