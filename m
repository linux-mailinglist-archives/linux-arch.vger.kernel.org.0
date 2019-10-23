Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A740E256E
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2019 23:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389939AbfJWVe0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Oct 2019 17:34:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406296AbfJWVe0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 23 Oct 2019 17:34:26 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0601521E6F
        for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2019 21:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571866465;
        bh=kEvURABwy5dE7dIZtr9WIuD+DQoD+YYLJ57x1dBZKbc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gxJIYb6cNfXlO6PgF2UE3M5U0+aE1ipzt4xEej08Gd0dre102440y81tGBr/6wJB5
         SRD59m026/VsnVUIKc4LKh40VRIN76Gy6H7yycewfV2PggxNshsMhm+wGrXb+3jCzU
         Dlq+FeaAesVq+2M1f73mDFfXmw5aaPWGw6pR+14M=
Received: by mail-wm1-f53.google.com with SMTP id c22so428044wmd.1
        for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2019 14:34:24 -0700 (PDT)
X-Gm-Message-State: APjAAAVfF1pvsJanr15e/TIBn1azUT3YoMoPc4bumrzGX0NGHgvH1zfV
        qC1bkRaNJo4S6OAzCpWmBpCjn/fBMyNiAuO1dmOAZg==
X-Google-Smtp-Source: APXvYqxmBg2CFH+tCYmWc0vnLev+bxj/rdn8n+v4NKHpG5kZO9lsJeafXzB09pL0boITaAD9Bx5KUbeyPmu4Odj/Tw8=
X-Received: by 2002:a1c:a556:: with SMTP id o83mr1913319wme.0.1571866463469;
 Wed, 23 Oct 2019 14:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <20191023122705.198339581@linutronix.de> <20191023123118.978254388@linutronix.de>
In-Reply-To: <20191023123118.978254388@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 23 Oct 2019 14:34:12 -0700
X-Gmail-Original-Message-ID: <CALCETrVArVWH2-ew4+WVxhX-3kzrspv2x8yw3RH3PyVGeAMudA@mail.gmail.com>
Message-ID: <CALCETrVArVWH2-ew4+WVxhX-3kzrspv2x8yw3RH3PyVGeAMudA@mail.gmail.com>
Subject: Re: [patch V2 14/17] entry: Provide generic exit to usermode functionality
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 23, 2019 at 5:31 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Provide a generic facility to handle the exit to usermode work. That's
> aimed to replace the pointlessly different copies in each architecture.


>  /**
> + * local_irq_enable_exit_to_user - Exit to user variant of local_irq_enable()
> + * @ti_work:   Cached TIF flags gathered with interrupts disabled
> + *
> + * Defaults to local_irq_enable(). Can be supplied by architecture specific
> + * code.

What did you have in mind here?
