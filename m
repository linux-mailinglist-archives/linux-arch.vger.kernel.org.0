Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D01F10A476
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2019 20:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfKZT1k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Nov 2019 14:27:40 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40274 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfKZT1k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Nov 2019 14:27:40 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so219181plp.7
        for <linux-arch@vger.kernel.org>; Tue, 26 Nov 2019 11:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YI4V2WssMRGVmL6esY08NHkJnNChKgI+Jb5umi12BtQ=;
        b=Qw05GjQOCTE0y6fF9w8dxZSi7PjeRJZGmubHGiYE6lEqhTc/TsMEQM/741ndwxuKxz
         RABNCdCMij6yPr8XiG8GCR6YgOR4GTepgetwvuUsq2MLfAK9Ix6kY2sYQawoY1UDdPpS
         WCEH1wUWZkJJGp6+hVeqJV/nSY/iD/a66JRIVe22/wJibBe+gqvjEXb1AOW/0iYRCuwL
         nnldZFDhH7fUblMqIDyz9eGLQ4Y7gC6VOfRHpBZp14QWxHnYwrD3md9Fdc1vrQzmRncb
         p+MrY4Hk8h2ij3N9VLdjYv2qhzA9m++8itAjRuQwVHDPj2JaaXR10cbbD7ZEkKeKojLq
         Bu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YI4V2WssMRGVmL6esY08NHkJnNChKgI+Jb5umi12BtQ=;
        b=JlRGI672gv1WWsITWoqk3n663/kOw5BOdaUVlBDBqycaxlve5K61AvWdY3iY5yIkns
         rKgN8JeeA+fbqsM+fPzEo7A8J+OWytmtR7mMH3RkCl+GLifQJteZrMpTK9JSN7e21j2W
         QKz4L5gMu2TdZee3MgG43JsG18qPoJZAqIexONvJK7otzmtnE9sNC2gcEBDw/j8eO65/
         UEQUh4I3GU5Fi+iFnut0FoJrma9smfFrcPVThbMs7Obia4UPeiJqEpZshl3kQYeLc4bO
         lCMxJNvUHx6tyZdyic0dBpTygVHQazoG62FN2I1palI+TY7WQJ3yznbY7JCcAw4x5KQ1
         4DFQ==
X-Gm-Message-State: APjAAAXn+DglqYEPjA1w4w2OrDzXe80SUG3iRuhFUz2ED1sa5o0N6k0y
        7aQ8DxYCSi4nJC3XToBWaDwykeuhqQ1Emj1heYVbPw==
X-Google-Smtp-Source: APXvYqxI0Hok6P5KawDA82lDpXYTcv4tCtUo+n70KHsCLSunjJ7EE9Wj9J+r5Ee2OnAv9XxMa+II+yHQ2pgcRk1/QF8=
X-Received: by 2002:a17:90a:bf81:: with SMTP id d1mr887094pjs.125.1574796459529;
 Tue, 26 Nov 2019 11:27:39 -0800 (PST)
MIME-Version: 1.0
References: <8736eaxxdg.fsf@x220.int.ebiederm.org>
In-Reply-To: <8736eaxxdg.fsf@x220.int.ebiederm.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 26 Nov 2019 11:27:29 -0800
Message-ID: <CAMo8BfK-Ua70sZe8JBHz3KK7+WjP1MvBa=jTK=-HrOHuAuDnHg@mail.gmail.com>
Subject: Re: new uses of SYSCTL_SYSCALL
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Eric,

On Tue, Nov 26, 2019 at 11:15 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Doing a test merge against linux-next I see that in the
> tree git://github.com/jcmvbkbc/linux-xtensa.git#xtensa-for-next
> a new defconfig is added:
>
> arch/xtensa/configs/xip_kc705_defconfig
>
> That defconfig adds CONFIG_SYSCTL_SYSCALL.
>
> Is xtensa actually using this system call?  So far I have not seen any
> other users and I am serously proposing to remove it.

I'm sure that this config symbol was inherited from some other config
that I used as a base for the xip_kc705_defconfig. I didn't enable it
intentionally. I'll drop it from the config and fix up the patch that
introduced it.

-- 
Thanks.
-- Max
