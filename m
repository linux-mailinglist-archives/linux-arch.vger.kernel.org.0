Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAE0741A4C
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jun 2019 04:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436496AbfFLCS3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jun 2019 22:18:29 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36435 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408385AbfFLCS2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jun 2019 22:18:28 -0400
Received: by mail-lf1-f66.google.com with SMTP id q26so10806980lfc.3
        for <linux-arch@vger.kernel.org>; Tue, 11 Jun 2019 19:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LQ6UZZSMFwXSziql0q4Iq7xcEoj6RMO4R+oEBZibVKs=;
        b=ZkjB2SoYz4qRYdkSnfCZtZukuCJA92FA1EX5eS3hQG3BjIweRCWV3Ub7+a8w6JYlL6
         eCwSKtL75JuS4EjDkdwu5ZyRTBSeu0W7upyx7WgPm4QcLL4VuXvFrhpEAN0G9jDF7ScK
         buYMGMugpVr42AxnvK6GO4t+hUwkB3oVIf11s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LQ6UZZSMFwXSziql0q4Iq7xcEoj6RMO4R+oEBZibVKs=;
        b=E9O1n73KdhaEcO32RJPchlVHNSGzLmaDY6AW6QSDbmMQkdV3X3QtxUB/FIfKSQHnz+
         6gx0PRw5kPczE+CiJjst9oLsZjboSLlQvOaPbuGvEJJ+d2NR/GviKYsAKuIrzm1hA9C2
         C2mvk+dqiFwwvHUoL6z9qHT/oypfrkCHb7FS5OM10dhDOJk2khvl9WdfUeQIn28kXKHe
         TiHHCFbzOG2moOb/SV1cma/FhNHW+hTBfyEZpWwLCvY1BxKL89hjdsTOd8j2malxwp29
         PvyNWEv4h3eh0z4T0uIoihsHR3BaLuNh1PL5Lc1ajUW9QCo5j469LPnwx3D8nNPi/y/E
         zG2Q==
X-Gm-Message-State: APjAAAX3hZS0bS6qc1ZCTDa//0ZeJqgfIAUnFz6sVMWl3hmgyXGTTqUY
        7JHlISov0Og0zS8SQi6maZhrf4gIbzg=
X-Google-Smtp-Source: APXvYqwmR4mMW4NysJ6BdgxlOrBSLGA4APDp4j9sN7JZ2+jRUuXKxpW0UFDNRmC/oiB8mGFSo4AW+g==
X-Received: by 2002:ac2:43cf:: with SMTP id u15mr38640598lfl.188.1560305905598;
        Tue, 11 Jun 2019 19:18:25 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 2sm1969797lju.52.2019.06.11.19.18.24
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 19:18:24 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id a21so13621852ljh.7
        for <linux-arch@vger.kernel.org>; Tue, 11 Jun 2019 19:18:24 -0700 (PDT)
X-Received: by 2002:a2e:9cd4:: with SMTP id g20mr747270ljj.205.1560305904002;
 Tue, 11 Jun 2019 19:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <156025961444.27052.12727156666287330749.stgit@warthog.procyon.org.uk>
In-Reply-To: <156025961444.27052.12727156666287330749.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Jun 2019 16:18:07 -1000
X-Gmail-Original-Message-ID: <CAHk-=wih2Ko+9CBRrdp36G7DPy4EDZKxZQ6q0CNyXRWsy5ujyA@mail.gmail.com>
Message-ID: <CAHk-=wih2Ko+9CBRrdp36G7DPy4EDZKxZQ6q0CNyXRWsy5ujyA@mail.gmail.com>
Subject: Re: [RFC PATCH] Add script to add/remove/rename/renumber syscalls and
 resolve conflicts
To:     David Howells <dhowells@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 11, 2019 at 3:27 AM David Howells <dhowells@redhat.com> wrote:
>
> Add a script that simplifies the process of altering system call tables in
> the kernel sources.  It has five functions available:

Ugh, I hate it.

I'm sure the script is all kinds of clever and useful, but I really
think the solution is not this kind of helper script, but simply that
we should work at not having each architecture add new system calls
individually in the first place.

IOW, we should look at having just one unified table for new system
call numbers, and aim for the per-architecture ones to be for "legacy
numbering".

Maybe that won't happen, but in the _hope_ that it happens, I really
would prefer that people not work at making scripts for the current
nasty situation.

                 Linus
