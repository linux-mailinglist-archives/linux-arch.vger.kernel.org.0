Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70CD41B2F5C
	for <lists+linux-arch@lfdr.de>; Tue, 21 Apr 2020 20:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbgDUSnT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Apr 2020 14:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729590AbgDUSnS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Apr 2020 14:43:18 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC4DC061BD3
        for <linux-arch@vger.kernel.org>; Tue, 21 Apr 2020 11:43:17 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id m2so11935799lfo.6
        for <linux-arch@vger.kernel.org>; Tue, 21 Apr 2020 11:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P3kAvJO++eguajRXsG/n5n7oYF1JgCMF+hUCYrN1/xg=;
        b=OrV75sJ7JQKXSTP33LjV3QbwQ+1OpDpShCbzluaAml47IaJlXUCvCFVNh0dT2ICaOR
         tP0ellSgXMcc5k5ikER9Nrb93hnp/fuQwpjpJAgKovwu7iy+//ZOUhUHick8HqdJW50T
         eqBCUYMnjMNZdxRwIOyjYkSeElTNWpr5H0uG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P3kAvJO++eguajRXsG/n5n7oYF1JgCMF+hUCYrN1/xg=;
        b=q0uK305Wwolugn4R37Cde67UtEebcgijRXZJVgfzYLb3LQWbq0JFvW8ggvV/IfjQdi
         XVoTLEvcAOt1YOrwf3birSxydCVuXs+amUc5Tu6y8zQ7mwHQDs2/8h5UY+zCy0gWIYvp
         RvlN0rtBtNAV0GPdnDlehLH7K9zs5sIPe5lZRopET2IW/dyojTJiYj+5fb1YnQmSO638
         HG77YTWLLPD8Kqn5VrZBLUys5R/dOIhuDC++o5W7655XaSajh4omYTG3TdovYWsIibil
         vIMIXi8W9E6cjBNJe0lunWUXmTumG6/ZsN5uM2hl3C0cICt4O879S456Q+NxFt+I0MY0
         vqHA==
X-Gm-Message-State: AGi0PuY6CQbdbLjcdDfQ3MjgZ2pW1PhQNA2aaX6asaH6tydmkSHHzuQ4
        /qrYWT28dnZhklBHZYUCDe/Kw7p/Rj8=
X-Google-Smtp-Source: APiQypKx9uZYWGq+gz6HSCalaA4JF87ws4Niyu8ZjmEsWPFtkVi0U0KEAuhlfJS3r8RYKrU7cpMfUQ==
X-Received: by 2002:a19:700b:: with SMTP id h11mr14773782lfc.89.1587494594955;
        Tue, 21 Apr 2020 11:43:14 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id u13sm2685155lji.27.2020.04.21.11.43.12
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 11:43:13 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id m2so11935657lfo.6
        for <linux-arch@vger.kernel.org>; Tue, 21 Apr 2020 11:43:12 -0700 (PDT)
X-Received: by 2002:a19:9109:: with SMTP id t9mr14821322lfd.10.1587494592604;
 Tue, 21 Apr 2020 11:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200421151537.19241-1-will@kernel.org>
In-Reply-To: <20200421151537.19241-1-will@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Apr 2020 11:42:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjjz927czq5zKkV1TUvajbWZGsPeFBSgnQftLNWmCcoSg@mail.gmail.com>
Message-ID: <CAHk-=wjjz927czq5zKkV1TUvajbWZGsPeFBSgnQftLNWmCcoSg@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] Rework READ_ONCE() to improve codegen
To:     Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 21, 2020 at 8:15 AM Will Deacon <will@kernel.org> wrote:
>
> It's me again. This is version four of the READ_ONCE() codegen improvement
> patches [...]

Let's just plan on biting the bullet and do this for 5.8. I'm assuming
that I'll juet get a pull request from you?

> (I'm interpreting the silence as monumental joy)

By now I think we can take that for granted.

Because "monumental joy" is certainly exactly what I felt re-reading
that "unqualified scalar type" macro.

Or maybe it was just my breakfast trying to say "Hi!".

                 Linus
