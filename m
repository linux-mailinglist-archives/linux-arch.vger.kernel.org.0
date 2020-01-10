Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E43B4137772
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2020 20:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbgAJTrD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jan 2020 14:47:03 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:47301 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbgAJTrD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jan 2020 14:47:03 -0500
Received: from mail-qk1-f180.google.com ([209.85.222.180]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M8hR1-1ilrVc3GzZ-004g7W; Fri, 10 Jan 2020 20:47:01 +0100
Received: by mail-qk1-f180.google.com with SMTP id z76so3023559qka.2;
        Fri, 10 Jan 2020 11:47:01 -0800 (PST)
X-Gm-Message-State: APjAAAXG//wpkJtsFh4QP7PLodBqQa5sfi2frBVdk6Ref9tO8HWED6ps
        MiFIIvrczXPl0x1D2sgSh7IoJB+S7dGjB2Oks5s=
X-Google-Smtp-Source: APXvYqw8EWa2FqtD3Swts+79Z/eWjkZogk6+1sZAnfKifOXUinM5+cnBupHXlwll6qOddsOCv97h3S3eeL+XRYPQP/c=
X-Received: by 2002:a05:620a:a5b:: with SMTP id j27mr4888379qka.286.1578685620608;
 Fri, 10 Jan 2020 11:47:00 -0800 (PST)
MIME-Version: 1.0
References: <20200110165636.28035-1-will@kernel.org>
In-Reply-To: <20200110165636.28035-1-will@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 10 Jan 2020 20:46:44 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1UzSOHdihbzOn5CZZfo1kvCdj7BAzdQE=PgYS9GBF4Hw@mail.gmail.com>
Message-ID: <CAK8P3a1UzSOHdihbzOn5CZZfo1kvCdj7BAzdQE=PgYS9GBF4Hw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] Rework READ_ONCE() to improve codegen
To:     Will Deacon <will@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:YPR8qgKCjRSZ5m5lyfH/hvPI9BfiP01HjLaLV8PZ/2XxXaWy9KT
 3Ydj3n/uCCW4qQAlzfve9ny2aK2Q0wzHI3vyaWJmr1ivVvMpC4+1HpsnAJsRb4PTNlNExFp
 7NBUCGjIkDh5z9N6E7heU1PzkA5d26GqPuWuyHNv7cKeHI5WAmmCXOC7WfNbekCLgTyc4oQ
 QPzOoqukoqj0bvfY2YtLw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PHMWjEJ2xxM=:vc7F7R/abmCfVnE9K9kbVD
 jd673uufKCU4zam2w5lmhogN1Cj2cT7VJV7rc9DZhJPCXuDhBciNwCyPwZZ9ewgGqhM4ZxAz/
 N/XeAJESGdQ4eXiJSX9ie2ljApsuPfRHADQZnzOiz0+mxJm+2MswJyRKYzXzJgOVl28RQwpRN
 l1BfePH0Jt/kiuW5Vi1OTXSscppgFy4aEbrZ1WsFuTEqEXpQbdL8SO9YKiESM2+Zg+e5yr9p9
 VOtbup4/HU79ddB+m4luir35zvgjW0WmYkEPwVZQ7qYGLNDzi+g9GMGWqYCDbulcnC7krsklR
 1YUPWlqZtG36c6Uz/uWwL93Xr70sCRWuKI5IW9kOTqVurZBCjdkfFoIfytZywdkV9YYlL3uSM
 IvlgpNIRBirfVMkpt72+PYEMPiz9HPk5FzDjR6929IoVgvwCQT8oLQejtVO+fmBoNJW+JKOo3
 psaq6lYkzI20i5fKMi5NS6jIDW2ZosH7sZ9D7MczCQDeQOLNQqvS2xA9mUuPXjYRrdXH7UgIk
 B64dceqxder/U6W/XpPwIYQCxVWakcZd5eih4CqKimg3BtQsSFxeyKEKIjJQE/QaeVtXTYPYK
 kULZxnaqpcbB4840jhN0NrAVgVQ6IpjmOnhlAPvU7iVvY1RI+hBMOc/bLDMoZnVgfYopDTXk6
 Y2MqYJi4osWS1m+EaQ76em6AOGFAt9H1kWQSu9K5oc+ddmFDLVLU0ZPEWNsht+zz3qKRh2tON
 xAgSyMRQ5iFXbhVaknc/IeHUNvQEc+phCNpgKAzE9FHk1WdYx2yNAPZW/XxAI3J5Yxs4tdB06
 Jz11pOrEcZVq2lGWc1m6F6guQEh0vn7xQraZ+eXhhqCOLpCxXw3CNf5l2xReiT1i656AN0Iso
 dsL+UuKRxJIGePz5W0Sw==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 10, 2020 at 5:56 PM Will Deacon <will@kernel.org> wrote:
>
> I have more patches in this area because I'm trying to move all the
> read_barrier_depends() magic into arch/alpha/, but I'm holding off until
> we agree on this part first.

Isn't the read_barrier_depends() the only reason for actually needing
the temporary local variable that must not be volatile?

If you make alpha provide its own READ_ONCE() as the first
step, it would seem that the rest of the series gets much easier
as the others can go back to the simple statement from your

#define __READ_ONCE(x)  (*(volatile __unqual_scalar_typeof(x) *)&(x))

      Arnd
