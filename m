Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F32A435438
	for <lists+linux-arch@lfdr.de>; Wed, 20 Oct 2021 21:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhJTUAd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Oct 2021 16:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhJTUAd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Oct 2021 16:00:33 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BE6C06161C
        for <linux-arch@vger.kernel.org>; Wed, 20 Oct 2021 12:58:18 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id d13so201178ljg.0
        for <linux-arch@vger.kernel.org>; Wed, 20 Oct 2021 12:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sg0o6MwSr5cVKhIKZL14YkinrZh0wp6xkfDKA7tp+7w=;
        b=FLcpWYGZhutnNkkuvkw53ygCMmmg9LwqTbT6ZB9EQ+0BzZdpzhVrWJpY+Ah74l6Fo3
         fKf8k8NzXJylaUyv4Ra6xGmCX2vWkERwH8CUBgfCgiM8z7LawcVJNAlJdfqFLr3ydLCn
         VVaz28NJzgchYxZ7U6J+aXnVc+mjIfIDWQ7Hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sg0o6MwSr5cVKhIKZL14YkinrZh0wp6xkfDKA7tp+7w=;
        b=asKN0V6Nph9qWc/Nyise6y4t+w3VWhtkG4X6dn+NaN8qrBvgHBm1LGsXcdgmCKRV9r
         DaOvRQ+DZSsCropft/s5hAqzjUnb/4nduzY40mSrvJi/nZINKwxFwEdTaiCN1pXdT4y6
         DKKOIlicy25mgsntMaSRGppgmAU+WFfvpejcUzANib+WstnwPJtqU+iqgXBaF+yErVHD
         /+zxsl9cnWGTLcK9817WodOHC5a+N5ZkVxEUt4Ho7sSNkE8eDkndVh9sRQ46qC3mu9IS
         URVJ+axx7koeUCjyy8dcl8momLDyPXnwujZ/AEoO/z1tuqyHg3o1VqSyBf0EZsvln8f/
         lGWw==
X-Gm-Message-State: AOAM533r+5lg9yGnP2lmcaWhHUWLlTY9Sv+mnj7VRBjsoYuyEVvtm4IL
        xKzHV9iUlUDD2ub4ate8t6E+OFMx9FbRbI2j
X-Google-Smtp-Source: ABdhPJx9Kp+qJQNGZcYKz4ltf3wpI4AKvxdY7e2a9OsehiPghfedHz+ttk6Zk0ayQ9ejhbblxOqVAA==
X-Received: by 2002:a05:651c:a06:: with SMTP id k6mr1117986ljq.237.1634759896305;
        Wed, 20 Oct 2021 12:58:16 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id n23sm267900lfe.7.2021.10.20.12.58.14
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 12:58:14 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id n7so277138ljp.5
        for <linux-arch@vger.kernel.org>; Wed, 20 Oct 2021 12:58:14 -0700 (PDT)
X-Received: by 2002:a2e:934d:: with SMTP id m13mr1155978ljh.191.1634759894116;
 Wed, 20 Oct 2021 12:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <87y26nmwkb.fsf@disp2133> <20211020174406.17889-6-ebiederm@xmission.com>
In-Reply-To: <20211020174406.17889-6-ebiederm@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Oct 2021 09:57:58 -1000
X-Gmail-Original-Message-ID: <CAHk-=whjqWwo16jtLduxb+0nbNetp8jNAz+go01wB4HGKX=jEQ@mail.gmail.com>
Message-ID: <CAHk-=whjqWwo16jtLduxb+0nbNetp8jNAz+go01wB4HGKX=jEQ@mail.gmail.com>
Subject: Re: [PATCH 06/20] signal/sh: Use force_sig(SIGKILL) instead of do_group_exit(SIGKILL)
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 20, 2021 at 7:44 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> +                       force_sig(SIGKILL);

I wonder if SIGFPE would be a more intuitive thing.

Doesn't really matter, this is a "doesn't happen" event anyway, but
that was just my reaction to reading the patch.

            Linus
