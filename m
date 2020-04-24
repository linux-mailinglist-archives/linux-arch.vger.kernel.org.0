Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660FB1B7BA8
	for <lists+linux-arch@lfdr.de>; Fri, 24 Apr 2020 18:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgDXQcE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Apr 2020 12:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgDXQcE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Apr 2020 12:32:04 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDE8C09B046
        for <linux-arch@vger.kernel.org>; Fri, 24 Apr 2020 09:32:03 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a21so10576577ljb.9
        for <linux-arch@vger.kernel.org>; Fri, 24 Apr 2020 09:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AW8riNWnz5YP0fa01Vg3qZdf63wXr2bbJtPsnhdpuY0=;
        b=hUtibbOzG1jq6xZz31PWBPpWmHymCNkdNvVaIJSds+orkWpz94LUfIy3rRi5gOPvoj
         eS+YTpU4kjuiC71NwhTsGsJLU4s4+251Pw4EEmDfy0BKZrgCXGZfO4/UEf17X9AZxZfJ
         S8MlPloXLY00QVd1wfHlCXp0N9UpykqfNovTz3+Dejq12O4wCPlZnY4/I6H79P/To3c/
         GMNfpNdniNPd+5sq94SpRDRqHvvCXO1E088FXO7jql3dSOM2zDbiQ1gWyhdSKMdpIoJ6
         1CHZpBoMbjhYzqotWw5f2XYff0A9GTb/CRHxTUkSt0WhifdIsMxrJRIUlcAdOGAisq3D
         se/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AW8riNWnz5YP0fa01Vg3qZdf63wXr2bbJtPsnhdpuY0=;
        b=WX0bg7UNmY2wzAr7S7Bphtii12YytgK67TNpa0e8cLWQTZfPsJ9VYiCOa0Ud0FKqb+
         2yW27FAzXo/QXXLGuxVvk6hOtYDI5SeF4baK6tbffi9mzMm8Tx66FNnHWSIQkA/lBmcm
         pZhZ0BbqMzlneT6XsZ9C+m/9gt9JPMQkXyc5hKZ2i1iGGnA5vFD1xI2YLKNW4mfqkjPi
         uQ1M20S5nre2Ep9fEc4UT13IuqGMBaYmrEoio0HwUkuDBqX1DytYNAjl11dSnQToFtUA
         4McAFfBeka7wNHKLClam98PjnIOdBD0MFp2nX0I5P+VJfPH53gBlO0/b5dcP55Im0NWX
         ZmoA==
X-Gm-Message-State: AGi0PubFkUxwpGPiWsaZDktqBFEL5t+U2DNuyXVO6vbsY2i8DoZhsAYf
        nU+Z/DQzgPBpU+FE3Eqwbo3hOFI/sJ8fYe4LT4doTIX1Dc8=
X-Google-Smtp-Source: APiQypL4OzRAhB+pZayaOxHwCw21g6ckPld6vaDQkhmXepvNZfvDqpergB0bdqfQYobjWWACC8OntZyyf9p1aTdc4EM=
X-Received: by 2002:a2e:8087:: with SMTP id i7mr5951576ljg.99.1587745921925;
 Fri, 24 Apr 2020 09:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200421151537.19241-1-will@kernel.org> <20200421151537.19241-8-will@kernel.org>
In-Reply-To: <20200421151537.19241-8-will@kernel.org>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 24 Apr 2020 18:31:35 +0200
Message-ID: <CAG48ez2n6g6nenHM8uB5U+e-Zo1PSA6n9LOBHeqG2HdUnwFpSQ@mail.gmail.com>
Subject: Re: [PATCH v4 07/11] READ_ONCE: Enforce atomicity for
 {READ,WRITE}_ONCE() memory accesses
To:     Will Deacon <will@kernel.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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

On Tue, Apr 21, 2020 at 5:15 PM Will Deacon <will@kernel.org> wrote:
> {READ,WRITE}_ONCE() cannot guarantee atomicity for arbitrary data sizes.
> This can be surprising to callers that might incorrectly be expecting
> atomicity for accesses to aggregate structures, although there are other
> callers where tearing is actually permissable (e.g. if they are using
> something akin to sequence locking to protect the access).
[...]
> The slight snag is that we also have to support 64-bit accesses on 32-bit
> architectures, as these appear to be widespread and tend to work out ok
> if either the architecture supports atomic 64-bit accesses (x86, armv7)
> or if the variable being accesses represents a virtual address and
> therefore only requires 32-bit atomicity in practice.
>
> Take a step in that direction by introducing a variant of
> 'compiletime_assert_atomic_type()' and use it to check the pointer
> argument to {READ,WRITE}_ONCE(). Expose __{READ,WRITE}_ONCE() variants
> which are allowed to tear and convert the one broken caller over to the
> new macros.
[...]
> +/*
> + * Yes, this permits 64-bit accesses on 32-bit architectures. These will
> + * actually be atomic in many cases (namely x86), but for others we rely on

I don't think that's correct?


$ cat 32bit_volatile_qword_read_write.c
#include <pthread.h>
#include <err.h>
#include <stdio.h>
#include <stdint.h>

/* make sure it really has proper alignment */
__attribute__((aligned(8)))
volatile uint64_t shared_u64;

static void *thread_fn(void *dummy) {
  while (1) {
    uint64_t value = shared_u64;
    if (value == 0xaaaaaaaaaaaaaaaaUL || value == 0xbbbbbbbbbbbbbbbbUL)
      continue;
    printf("got 0x%llx\n", (unsigned long long)value);
  }
  return NULL;
}

int main(void) {
  printf("shared_u64 at %p\n", &shared_u64);
  pthread_t thread;
  if (pthread_create(&thread, NULL, thread_fn, NULL))
    err(1, "pthread_create");

  while (1) {
    shared_u64 = 0xaaaaaaaaaaaaaaaaUL;
    shared_u64 = 0xbbbbbbbbbbbbbbbbUL;
  }
}
$ gcc -o 32bit_volatile_qword_read_write
32bit_volatile_qword_read_write.c -pthread -Wall
$ ./32bit_volatile_qword_read_write | head # as 64-bit binary
^C
$ gcc -m32 -o 32bit_volatile_qword_read_write
32bit_volatile_qword_read_write.c -pthread -Wall
$ ./32bit_volatile_qword_read_write | head # as 32-bit binary
shared_u64 at 0x56567030
got 0xaaaaaaaabbbbbbbb
got 0xbbbbbbbbaaaaaaaa
got 0xaaaaaaaabbbbbbbb
got 0xbbbbbbbbaaaaaaaa
got 0xbbbbbbbbaaaaaaaa
got 0xbbbbbbbbaaaaaaaa
got 0xbbbbbbbbaaaaaaaa
got 0xbbbbbbbbaaaaaaaa
got 0xbbbbbbbbaaaaaaaa
$


AFAIK 32-bit X86 code that wants to atomically load 8 bytes of memory
has to use CMPXCHG8B; and gcc won't generate such code just based on a
volatile load/store.
