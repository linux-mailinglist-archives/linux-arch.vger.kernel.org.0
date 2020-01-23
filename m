Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C26B2147116
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2020 19:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgAWSsC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jan 2020 13:48:02 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38328 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728792AbgAWSsC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jan 2020 13:48:02 -0500
Received: by mail-lf1-f67.google.com with SMTP id r14so3137164lfm.5
        for <linux-arch@vger.kernel.org>; Thu, 23 Jan 2020 10:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nTTlf7PIq8m+h1b8hl1eM7lP8o081tv0+h5Byplabe4=;
        b=Mj9KYt/E2aNDAWdYyMNCrPSCFRO71sOFNKIv1qcIG2H25vJy2SyD3sMLVq4FaDcfeP
         iGlcEsouR1fuzQs9IjFsmMH6TyLgOGNtzw0PWZ+6esf3f+uNHjTwy2QjoAL8divZL0PF
         0AN44j8uLfXOosmSCqaAgRkchGVu+6EMdfKNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nTTlf7PIq8m+h1b8hl1eM7lP8o081tv0+h5Byplabe4=;
        b=BuxBJuZ+7CwDWIaUUFGxcw9zunNvbRkXS1vjRvvkOI/kRHQkmwHvxUlwPPJjHPYWGG
         aGTMPV+okFD8Uff/qYjlw3LmG1zSX0Dq8vR5HY8J2UmtBQ5Y3fVw1vx37ttpoa1TGP/p
         A8JE6I1pLk0KX7dvWW+cGrCS3/IvKG5fq6/9TQ5wlQrarAehktj9vdE6wsrlFVxoBCFW
         BEvVCEaceY6nAL7miOohp6V9Bjjp0W9KlNlV16Qe0LJQj6l6NZKUEW0MnzVvK36XogwL
         EDL7rdbUgmYciQVDaBi4MMNQ2m2n/94g5EOYn/vKEBO1lK8hrJZxCaUeWubH7yj3sTjF
         rT6A==
X-Gm-Message-State: APjAAAXiDXYfynZEZK27f6QC8QSyvgKgjgJx7u7tv5NhdjqLWIRp5Jx4
        M5bBO33tgDo1s3qtfOuGLsSfMjJgmu8=
X-Google-Smtp-Source: APXvYqyo1i2JayVM7AD9IKNJ3dDL+K8zWZcv9BqjeDt7tvs5dpnzYv64n0kw8vBzgnwu4SxXxwUsoQ==
X-Received: by 2002:a19:7b0a:: with SMTP id w10mr5510246lfc.90.1579805279345;
        Thu, 23 Jan 2020 10:47:59 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id u15sm1514225lfl.87.2020.01.23.10.47.58
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 10:47:58 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id z26so3097454lfg.13
        for <linux-arch@vger.kernel.org>; Thu, 23 Jan 2020 10:47:58 -0800 (PST)
X-Received: by 2002:a19:4849:: with SMTP id v70mr5482335lfa.30.1579805278133;
 Thu, 23 Jan 2020 10:47:58 -0800 (PST)
MIME-Version: 1.0
References: <70f99f7474826883877e84f93224e937d9c974de.1579767339.git.christophe.leroy@c-s.fr>
In-Reply-To: <70f99f7474826883877e84f93224e937d9c974de.1579767339.git.christophe.leroy@c-s.fr>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Jan 2020 10:47:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgcm5JzyacekDGQ4Ocoe-F5it-7-sbgU8oPnhwnSH3KAA@mail.gmail.com>
Message-ID: <CAHk-=wgcm5JzyacekDGQ4Ocoe-F5it-7-sbgU8oPnhwnSH3KAA@mail.gmail.com>
Subject: Re: [PATCH] lib: Reduce user_access_begin() boundaries in
 strncpy_from_user() and strnlen_user()
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-arch <linux-arch@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 23, 2020 at 12:34 AM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
> The range passed to user_access_begin() by strncpy_from_user() and
> strnlen_user() starts at 'src' and goes up to the limit of userspace
> allthough reads will be limited by the 'count' param.
>
> On 32 bits powerpc (book3s/32) access has to be granted for each 256Mbytes
> segment and the cost increases with the number of segments to unlock.
>
> Limit the range with 'count' param.

Ack. I'm tempted to take this for 5.5 too, just so that the
unquestionably trivial fixes are in that baseline, and the
infrastructure is ready for any architecture that has issues like
this.

Adding 'linux-arch' to the participants, to see if other architectures
are at all looking at actually implementing the whole
user_access_begin/end() dance too..

               Linus
