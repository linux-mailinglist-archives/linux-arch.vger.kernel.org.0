Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 733C116873E
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 20:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbgBUTKU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 14:10:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:50220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729407AbgBUTKU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Feb 2020 14:10:20 -0500
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CD122467E
        for <linux-arch@vger.kernel.org>; Fri, 21 Feb 2020 19:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582312219;
        bh=UuhNfeKn532RnvokafaA9jeGYJ66WH3o9jZo/Sjed50=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=unz4oQ/7TC92dKV3E0jiYOZiHhYJwj5JnpZtdvdxLN6WVtKs+E76VPQmoRGOP/0Ls
         59ic49hwmZqs++ykC3FqdUHu56Y5/LYC6KpGweH979p8VnXYGlwI7NvrIYIiRo8Z/g
         H97jnDAcgVZ7FyaD4D3EMcDoi/um2epByqJPS1pY=
Received: by mail-wm1-f51.google.com with SMTP id a5so2887530wmb.0
        for <linux-arch@vger.kernel.org>; Fri, 21 Feb 2020 11:10:19 -0800 (PST)
X-Gm-Message-State: APjAAAUmk59ab6MdHvnecsk/Y4rZcwI/3W3FqfFnqSBaRPnLq7bg39vX
        KqiTRvKcVW9Z3832w3YTAOG7dnNQUuVoMRN1MDkKCQ==
X-Google-Smtp-Source: APXvYqyspFB2iIO50J3tDK8jOj0B1Z8Z06Wn6TefE3AoSD02hOu3MzrfXq42HPjiRp9ZzEARqYhZvwJ9X+EVJ8Ba6xc=
X-Received: by 2002:a1c:b0c3:: with SMTP id z186mr5163664wme.36.1582312217931;
 Fri, 21 Feb 2020 11:10:17 -0800 (PST)
MIME-Version: 1.0
References: <20200221133416.777099322@infradead.org> <20200221134215.385886177@infradead.org>
In-Reply-To: <20200221134215.385886177@infradead.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 21 Feb 2020 11:10:05 -0800
X-Gmail-Original-Message-ID: <CALCETrWmnkrHi1FYFLvj5G7SrmN+BrwLgKyt=NBtd-EOoRyeSQ@mail.gmail.com>
Message-ID: <CALCETrWmnkrHi1FYFLvj5G7SrmN+BrwLgKyt=NBtd-EOoRyeSQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/27] x86/doublefault: Remove memmove() call
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Greg KH <gregkh@linuxfoundation.org>, gustavo@embeddedor.com,
        Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 21, 2020 at 5:50 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Use of memmove() in #DF is problematic when you consider tracing and
> other instrumentation.
>
> Remove the memmove() call and simply write out what need doing; Boris
> argues the ranges should not overlap.
>
> Survives selftests/x86, specifically sigreturn_64.
>
> (Andy ?!)

Acked-by: Andy Lutomirski <luto@kernel.org>

Even ignoring the tracing issue, I think this is nicer than the original code.
