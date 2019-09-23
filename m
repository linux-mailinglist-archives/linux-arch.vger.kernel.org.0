Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52FE4BBB22
	for <lists+linux-arch@lfdr.de>; Mon, 23 Sep 2019 20:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440433AbfIWSSr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Sep 2019 14:18:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438391AbfIWSSr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 23 Sep 2019 14:18:47 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BEEB21906
        for <linux-arch@vger.kernel.org>; Mon, 23 Sep 2019 18:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569262726;
        bh=LO4GTKKSHWB9kcHekO7hnomAZooSVXs0I2xg7poD4DY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j0BZXQIpX2MOlhf9SNznn8IGzntp+2babJIqLVhkcA9epdql6lJxsc3WfrZx4AT2H
         sCnl/bTZ5yOO4OB4REdI7QlHWu57x01sWSen0jTwTw33GaDgw8KHXRFivZkFtwGjq1
         /saaLIbAjaaHg35vxirC2Q74D3G6RlwxqQiPpEJU=
Received: by mail-wm1-f47.google.com with SMTP id m18so10343045wmc.1
        for <linux-arch@vger.kernel.org>; Mon, 23 Sep 2019 11:18:46 -0700 (PDT)
X-Gm-Message-State: APjAAAWcLCKx+DCdw0LkhXCWIGopcTcLBNiKrBzaepLXvjxMNeoDbM4c
        7caMd0+6JwBrXa+4PilJoK8HasVx7hK9JHRsoBY/lw==
X-Google-Smtp-Source: APXvYqyuY3H2DKNpr0Bzr8dbUHAxIiCTpvK12u2LHOiAR0CZVPK82iYnYzgf0u3M5gP9FATk1J7gn1h2vcuI6Q6N73Y=
X-Received: by 2002:a1c:6143:: with SMTP id v64mr689647wmb.79.1569262724979;
 Mon, 23 Sep 2019 11:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190919150314.054351477@linutronix.de>
In-Reply-To: <20190919150314.054351477@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 23 Sep 2019 11:18:33 -0700
X-Gmail-Original-Message-ID: <CALCETrVpG9iH821LMuL5OOrAeRekYjYE9fyK3KkCwohN6ZUcXg@mail.gmail.com>
Message-ID: <CALCETrVpG9iH821LMuL5OOrAeRekYjYE9fyK3KkCwohN6ZUcXg@mail.gmail.com>
Subject: Re: [RFC patch 00/15] entry: Provide generic implementation for host
 and guest entry/exit work
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 19, 2019 at 8:09 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> When working on a way to move out the posix cpu timer expiry out of the
> timer interrupt context, I noticed that KVM is not handling pending task
> work before entering a guest. A quick hack was to add that to the x86 KVM
> handling loop. The discussion ended with a request to make this a generic
> infrastructure possible with also moving the per arch implementations of
> the enter from and return to user space handling generic.
>
>   https://lore.kernel.org/r/89E42BCC-47A8-458B-B06A-D6A20D20512C@amacapital.net
>
> You asked for it, so don't complain that you have to review it :)
>
> The series implements the syscall enter/exit and the general exit to
> userspace work handling along with the pre guest enter functionality.
>
> The series converts x86 and ARM64. x86 is fully tested including selftests
> etc. ARM64 is only compile tested for now as my only ARM64 testbox is not
> available right now.

Other than the comments I sent so far, I like this series.
