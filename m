Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2EB348BBB
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jun 2019 20:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfFQSQW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Jun 2019 14:16:22 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34000 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfFQSQW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Jun 2019 14:16:22 -0400
Received: by mail-lj1-f194.google.com with SMTP id p17so10294827ljg.1
        for <linux-arch@vger.kernel.org>; Mon, 17 Jun 2019 11:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3KbGZcl0Gi0jNy9coPKcSJr5heE7ZQLRdeNj3JGzwpA=;
        b=T15jTJllZ2uRduB3YrgRGX6wMT+z9NIUkv1VPJmC8yz0PENs8is1UxhM80bHpn8Wjc
         LHml4nVfexaFPrpvousJxFP6ZKHWn6WTtjuwP5+9yj+P/JOWZf04CZCjP8YosgpSq8m6
         YDg70VW3sT3LWCqjEU3XU9676uzdpl6cv7EhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3KbGZcl0Gi0jNy9coPKcSJr5heE7ZQLRdeNj3JGzwpA=;
        b=mchb7cFUKLW4OjOqxx189LliJwNBcy+3CTbaARHgzbKRjtFnIoQVYbBNdHkOOakM6W
         Z0XpZTORRfuYr+bH1YuMu5QxaOlEZehQ7k7x1qAYwR04ilxlXDW0p+Z6xJ2dils/4xsn
         QeBbu0N7s/m3S1I9N7MXdJabnK8uQhxqfjIL8idzUETy6rotXZ+0+B42eJEa7dZLN74n
         8e7wIPxxjIk9OYgGueEy7o9LkEx94LY2k1CfGLMgAf8MlT5ON2LRY4Cd6wKLYdz1f3uw
         L9FyYHHl/BaE8owxJ3SZNrQWYmij3M9vHedcMJ88B+ljs0j0FWS+v60/IKIXP2aA9aMn
         hJYA==
X-Gm-Message-State: APjAAAUvrBbgrk4NqRMqRbNmWCeSLn76CpjOP3KQe2OJWy+0dbbUJlm/
        KR27goPxPhyIpjNCimQ6mynHZo1nMIg=
X-Google-Smtp-Source: APXvYqzkdsnXcGK4epQ1jERm/P9LO7CM674v1ZLqQGlV5tT8693jSIg8Fj4cnRVAHQPLVt7pAXQMNg==
X-Received: by 2002:a2e:9c85:: with SMTP id x5mr22686382lji.139.1560795380517;
        Mon, 17 Jun 2019 11:16:20 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id v14sm2194894ljh.51.2019.06.17.11.16.19
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 11:16:19 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id a21so10259423ljh.7
        for <linux-arch@vger.kernel.org>; Mon, 17 Jun 2019 11:16:19 -0700 (PDT)
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr30169158ljm.180.1560795379164;
 Mon, 17 Jun 2019 11:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190319165123.3967889-1-arnd@arndb.de> <alpine.DEB.2.21.1905072249570.19308@digraph.polyomino.org.uk>
 <87tvd2j9ye.fsf@oldenburg2.str.redhat.com> <CAHk-=wio1e4=WUUwmo-Ph55BEgH_X3oXzBpvPyLQg2TxzfGYuw@mail.gmail.com>
 <871s05fd8o.fsf@oldenburg2.str.redhat.com> <CAHk-=wg4ijSoPq-w7ct_VuZvgHx+tUv_QX-We-62dEwK+AOf2w@mail.gmail.com>
 <87sgs8igfj.fsf@oldenburg2.str.redhat.com> <CAHk-=wjCwnk0nfgCcMYqqX6o9bBrutDtut_fzZ-2VwiZR1y4kw@mail.gmail.com>
 <87k1dkdr9c.fsf@oldenburg2.str.redhat.com> <CAHk-=wgiZNERDN7p-bsCzzYGRjeqTQw7kJxJnXAHVjqqO8PGrg@mail.gmail.com>
In-Reply-To: <CAHk-=wgiZNERDN7p-bsCzzYGRjeqTQw7kJxJnXAHVjqqO8PGrg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Jun 2019 11:16:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=whkCOVzXeju8H8iWeh-vWorpWSZG6USFKcOWQ36XokZMA@mail.gmail.com>
Message-ID: <CAHk-=whkCOVzXeju8H8iWeh-vWorpWSZG6USFKcOWQ36XokZMA@mail.gmail.com>
Subject: Re: [PATCH] uapi: avoid namespace conflict in linux/posix_types.h
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Joseph Myers <joseph@codesourcery.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Paul Burton <pburton@wavecomp.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 17, 2019 at 11:13 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That one we might be able to just fix by renaming "fds_bits" to "__fds_bits".

That said, moving it to another file might be the better option anyway.

I think fd_set and friends are now supposed to be in <sys/select.h>
anyway, and the "it was in <sys/types.h>" is all legacy.

                 Linus
