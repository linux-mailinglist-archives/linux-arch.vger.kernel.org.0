Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAA9123451
	for <lists+linux-arch@lfdr.de>; Tue, 17 Dec 2019 19:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbfLQSEw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Dec 2019 13:04:52 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40375 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbfLQSEu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 17 Dec 2019 13:04:50 -0500
Received: by mail-lf1-f67.google.com with SMTP id i23so7614096lfo.7
        for <linux-arch@vger.kernel.org>; Tue, 17 Dec 2019 10:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lR1SiqLK9KEC99vqrA+L06g5eY9Mbqq1o4Gp42LpZMk=;
        b=FK7jv4qNRsEY58xZMc+UmIyte9eMcd0a4A+t48QkMIcc8UodbMREUJO3iZzA7AKpln
         03BKAH+vqDBR3VhNEzal6BtSu2hnn/lsLynWDxYrv66nuQYJnVSbzh2V+rbyH0fyrq1C
         njp7EPb9EhK3H7gTZQ8M3AOVEH2nTx7zrpL6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lR1SiqLK9KEC99vqrA+L06g5eY9Mbqq1o4Gp42LpZMk=;
        b=dpUmfUWQFpoVHvF5fzo2x3WzMdgzb8uJLqN4dv0gAaBUH0lxTYYVoPwadAWST5MCh7
         xB4rWLs9TYJVzNv1VyahVshYs3T4GroyMBPQngqqblPvmT9kpvUsBS68AoOv4FeOTmZ4
         ZkWc5qvWy6iFdX+WOK8YFlCAmbpsBlxd9BGH8Xb2z8iSBGkJUjEQm9F6sY475IuPqD7w
         FxovgU+s3iVquEv8M28ZyiI2PLr4BSJygoLNX9M1N/alSQhZ4APKpc1n77EgNdg4ynEl
         sM4yQKbu0cZBnvA4J1NhAd5glPBZAa/NZgPJJ9aYffnhD3jGz3Awbas0sdUb6c+8usNV
         RToA==
X-Gm-Message-State: APjAAAVaPR4puKSpREXL9tXg41+nzMnaLb0wJE8UTsCeVebdwvKWStkR
        JjetJ+9YeGZteoeMpi4SkVMSl6kYv28=
X-Google-Smtp-Source: APXvYqwXMpExqoAxF2KPgTWj1Ok62XCicG191UDVuXTvFBa0oEduHO4bvcb5lH4Sj5wowSOQIUU9oQ==
X-Received: by 2002:a05:6512:284:: with SMTP id j4mr3388789lfp.109.1576605887593;
        Tue, 17 Dec 2019 10:04:47 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id a21sm11109926lfg.44.2019.12.17.10.04.45
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 10:04:45 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id k8so632729ljh.5
        for <linux-arch@vger.kernel.org>; Tue, 17 Dec 2019 10:04:45 -0800 (PST)
X-Received: by 2002:a2e:99d0:: with SMTP id l16mr4244505ljj.1.1576605885112;
 Tue, 17 Dec 2019 10:04:45 -0800 (PST)
MIME-Version: 1.0
References: <20191212100756.GA11317@willie-the-truck> <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck> <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
 <20191212193401.GB19020@willie-the-truck> <CAHk-=wiMuHmWzQ7-CRQB6o+SHtA-u-Rp6VZwPcqDbjAaug80rQ@mail.gmail.com>
 <20191217170719.GA869@willie-the-truck>
In-Reply-To: <20191217170719.GA869@willie-the-truck>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Dec 2019 10:04:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=whBnZBVNwu8aVVp205EKk7xtsnQgSjs38a5=y9HyheXzQ@mail.gmail.com>
Message-ID: <CAHk-=whBnZBVNwu8aVVp205EKk7xtsnQgSjs38a5=y9HyheXzQ@mail.gmail.com>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Axtens <dja@axtens.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 17, 2019 at 9:07 AM Will Deacon <will@kernel.org> wrote:
>
> However, I'm really banging my head against the compiler trying to get
> your trick above to work for pointer types when the pointed-to-type is
> not defined.

You are right, of course. The trick works fine with arithmetic types,
but since it does use arithmetic, it requires that pointer types be
not only declared, but defined. The addition wants the size of the
underlying type (even though with an addition of zero it wouldn't be
required - but that's not how C works).

Let me think about it.

             Linus
