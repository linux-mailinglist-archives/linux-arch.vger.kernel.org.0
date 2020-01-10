Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7456B1377CA
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2020 21:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbgAJUPG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jan 2020 15:15:06 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41493 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgAJUPF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jan 2020 15:15:05 -0500
Received: by mail-lj1-f195.google.com with SMTP id h23so3390389ljc.8
        for <linux-arch@vger.kernel.org>; Fri, 10 Jan 2020 12:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EoKs7DLXvXqzDjIjK2Ln0baXpWf36RRq1PcuXotv7ds=;
        b=hnSVZpJB53NNn6wqLpSOhHsie6VkBQEhcfCNwu+IHx45RVrdgQBN5WMCD6SVMTtkIb
         AKlODwqEkeLtznWH6lwg/G2wzFnfIZLC+c9uzR45JzOvrs+qQeAoUcNuWZjoe0U3/8ew
         gdD49lYD2Irh400cM65Hhjn8BpzwdZpGgohuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EoKs7DLXvXqzDjIjK2Ln0baXpWf36RRq1PcuXotv7ds=;
        b=EueD871sAH0MqwloDmvvXQIZEUnXcFZcdEzWtNc8kEW9u01mJtckPi1DwuwtYpI3zj
         d2judvFZywyTZDYUI94nNpGLC5D0hHzuoQXdWA/eIBqfBc6GHhzK0w+f8790fJG3mNH3
         DcBl3XzQzIRUPZChx2a0UtstO7CErpvsnwBrb6IN27sdNT4xPSC+2p88yK7MItxNW1jh
         XcUYdr8xU7c2wuflaK3XcWQ02m7X78l5/c/rolBlTY+sy8dExOEUyiX/JfOG0/iLY0LU
         N4QqP5wVxTBXCa92hmF07+5EL2myNT6LtCx9CAngt9gcvbj8Z+J5FDByaQ00kRmxDrfj
         vfjw==
X-Gm-Message-State: APjAAAWLRZbihd1pc9lWrhmAmHIQD3QES7oDcIZAVk9BDagwLXHjMb+K
        BqE5UV55BqXD5lSj8p9Ehm+S+F4UqNs=
X-Google-Smtp-Source: APXvYqyOcATdBx/+5TyJvOrlHvE9SuF8tDzadDp1QJLVa86w21qdu9XE3f/2MxHripp9g431o/BsiQ==
X-Received: by 2002:a2e:b5d5:: with SMTP id g21mr3758680ljn.89.1578687302949;
        Fri, 10 Jan 2020 12:15:02 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id j22sm1540185lfh.93.2020.01.10.12.15.01
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 12:15:01 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id r14so2428634lfm.5
        for <linux-arch@vger.kernel.org>; Fri, 10 Jan 2020 12:15:01 -0800 (PST)
X-Received: by 2002:ac2:5216:: with SMTP id a22mr3444153lfl.18.1578687301360;
 Fri, 10 Jan 2020 12:15:01 -0800 (PST)
MIME-Version: 1.0
References: <20200110165636.28035-1-will@kernel.org> <CAK8P3a1UzSOHdihbzOn5CZZfo1kvCdj7BAzdQE=PgYS9GBF4Hw@mail.gmail.com>
In-Reply-To: <CAK8P3a1UzSOHdihbzOn5CZZfo1kvCdj7BAzdQE=PgYS9GBF4Hw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Jan 2020 12:14:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wggv_LmrL85Ez0TLcAku8iz05VZmJxDGo=2aP2VvQtrsA@mail.gmail.com>
Message-ID: <CAHk-=wggv_LmrL85Ez0TLcAku8iz05VZmJxDGo=2aP2VvQtrsA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] Rework READ_ONCE() to improve codegen
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 10, 2020 at 11:47 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Isn't the read_barrier_depends() the only reason for actually needing
> the temporary local variable that must not be volatile?
>
> If you make alpha provide its own READ_ONCE() as the first
> step, it would seem that the rest of the series gets much easier
> as the others can go back to the simple statement from your

Hmm.. The union still would cause that "take the address of a volatile
thing on the stack" problem, wouldn't it? And that was what caused
most of the issues.

I think the _real_ issue is how KASAN forces that odd pair of inline
functions in order to have the annotations on the accesses.

                Linus
