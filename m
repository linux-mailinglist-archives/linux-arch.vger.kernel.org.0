Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3C339860
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jun 2019 00:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbfFGWPe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Jun 2019 18:15:34 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38888 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730177AbfFGWPe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jun 2019 18:15:34 -0400
Received: by mail-lf1-f66.google.com with SMTP id b11so2711438lfa.5
        for <linux-arch@vger.kernel.org>; Fri, 07 Jun 2019 15:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7jg1F7lO7uVdQ9tdkXQLyc2uUklR2L0U9AiiLwg+uvg=;
        b=aoO38c3t9rsjPFOteILVcuGQgCSWmQvFmxqe1O+LyeoYe2aN68r4/UJ6/k8U6kDF+9
         k5nu15rfkguUHB69Ug3k1zaCjiMfZbLwrN5OOkDfDyFaGoeL8MWvfl6J09wlT65fi1IT
         7aToDUMiC1CDBV3U4Q7S4ZrpIP6miijco5Te8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7jg1F7lO7uVdQ9tdkXQLyc2uUklR2L0U9AiiLwg+uvg=;
        b=V0j/3Z0hCX8DL3K8olxhXCsey3a5mAgxaaWcEBK4A8EdqZzojD1Z5Q1tE8pUQ/+d5l
         WGTTF87CTNXUlJMGjWdd5wNDGSImJF6YqdUbg9a09AzqusSa+rC7h/asoxzNQsEvPdtd
         dP7yr9NCu+ZA/noECZi+2lM/ao8zcr2tVOU/oS2axHE2mADsAyPCbQUrQAWsma0/XO+s
         tQSTHekG7Sf2DCqmhBXEsAX9nNAcAXShOyazupnVgZvDBhd4XwzVJSRfLEdUo4IWTD5z
         I5Fhr4i2njfF+I3JWgUU1R11R4INDeZ26HZTtGZdhDCp0ySGvoqi0YqJfjhFIV5DExNw
         bc1A==
X-Gm-Message-State: APjAAAVqTsWAiOVeN+W48gNiIRIaEMMMJI/BtbdbI33FOnFxjArEkRBj
        XH+YCsVPvxaNZiR3Tvuqq+9ULPdhB1lang==
X-Google-Smtp-Source: APXvYqyRTLczizOyLXWf5Igx6IEvnFUpuXjxPyh1UAe3gZjH7RWyQh1qAlVf+DT77nOByjh5sQbAnw==
X-Received: by 2002:ac2:54a6:: with SMTP id w6mr27031276lfk.108.1559945732173;
        Fri, 07 Jun 2019 15:15:32 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id r3sm565410ljr.76.2019.06.07.15.15.31
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 15:15:31 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id i21so3026660ljj.3
        for <linux-arch@vger.kernel.org>; Fri, 07 Jun 2019 15:15:31 -0700 (PDT)
X-Received: by 2002:a2e:4246:: with SMTP id p67mr29323271lja.44.1559945263826;
 Fri, 07 Jun 2019 15:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
 <20190529161157.GA27659@redhat.com> <20190604134117.GA29963@redhat.com>
 <20190606140814.GA13440@redhat.com> <87k1dxaxcl.fsf_-_@xmission.com> <87ef45axa4.fsf_-_@xmission.com>
In-Reply-To: <87ef45axa4.fsf_-_@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Jun 2019 15:07:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjjVnEKSv3pV_dvgmqGDZDcw+N+Bgcorq7uqS86f1gwXA@mail.gmail.com>
Message-ID: <CAHk-=wjjVnEKSv3pV_dvgmqGDZDcw+N+Bgcorq7uqS86f1gwXA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] signal: Teach sigsuspend to use set_user_sigmask
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Davidlohr Bueso <dbueso@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Davidlohr Bueso <dave@stgolabs.net>, Eric Wong <e@80x24.org>,
        Jason Baron <jbaron@akamai.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-aio@kvack.org, omar.kilani@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Laight <David.Laight@aculab.com>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 7, 2019 at 2:41 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> The sigsuspend system call overrides the signal mask just
> like all of the other users of set_user_sigmask, so convert
> it to use the same helpers.

Me likey.

Whole series looks good to me, but that's just from looking at the
patches. Maybe testing shows problems..

              Linus
