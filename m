Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 056EA1174D7
	for <lists+linux-arch@lfdr.de>; Mon,  9 Dec 2019 19:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfLISsd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Dec 2019 13:48:33 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:44862 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfLISsc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Dec 2019 13:48:32 -0500
Received: by mail-io1-f67.google.com with SMTP id z23so15839591iog.11
        for <linux-arch@vger.kernel.org>; Mon, 09 Dec 2019 10:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zi2mbcA3dI0Tp/DpO+thSwq2zZZGqpVehuHAqxL+i5c=;
        b=LGfA1Taelzd+PatnajvxDFPlsISUHMFnQWVwAolBrXJGwNVRpSKxeSHaFDTeMc/ptL
         hEulU4FMnI7+6PQRJEC6wn5Zz3/ecd+c9iUfpIoXAfZm1Oc+2xGPCXvHwUG6TQ5Zvy2t
         s5aLS7r1cbj7m0+O93Ae4OUPcSIPg/Nuy9b+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zi2mbcA3dI0Tp/DpO+thSwq2zZZGqpVehuHAqxL+i5c=;
        b=Ub5qFWKlkVdTZq7MvQDX8bS4xJkd2GxlNHlqmJ/XqriyrVUlzjsNE3FxSnO8SPfQNj
         SVbeDG3vvW0GCPy4vmXwLY+nZJpw46dOS+A+CKXw3h0cr1TNr6OSSJ+3nSv8yaE2syvu
         CsgfbPa1xazcMdu6e5Z9AgZZqFm/dYdKFGTuLsd6FwUE97E41OBJGvIJ6QgWc2xJgZna
         nXCiejas8kgeqWopGkb9WGVUPgU7mFZfJMRXNrg0wr+isJL0wcJEIjsgrxi5KiyQXHsO
         6sq6jgcEy1EBIkyZhzKqpGpNg8Ue6fNkD+BOXn8LjDivoKwgBS/J+iporfXnYOoL/3Gb
         si8g==
X-Gm-Message-State: APjAAAV0lAi4fdLkwU53FR8Adr8b7Wsfe1/N+RnvifcrAFGBnmPJnVvK
        uXeloA1Pc8GBa2No9Hfy7MPFFGCco+ssxScCSn0PYg==
X-Google-Smtp-Source: APXvYqylpzBA/rEOG36qxdMJP/TXW5tXH1kkcXg24MQVyc8HWod7DLw4mYvfIqk4ydMjgej/CHEZBfcOnbDj+lKD+aE=
X-Received: by 2002:a02:ce5c:: with SMTP id y28mr28638212jar.96.1575917312372;
 Mon, 09 Dec 2019 10:48:32 -0800 (PST)
MIME-Version: 1.0
References: <20191209135823.28465-1-hch@lst.de>
In-Reply-To: <20191209135823.28465-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 9 Dec 2019 10:48:20 -0800
Message-ID: <CAADWXX9zEBT-NPCwE09D+6=8iCZ+kCmdyXoGrTKhnmYn82XEJQ@mail.gmail.com>
Subject: Re: RFC: kill off ioremap_nocache
To:     Christoph Hellwig <hch@lst.de>
Cc:     Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-mips <linux-mips@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 9, 2019 at 5:58 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Let me know what you think and if this is something acceptable for
> just after -rc1.

How many conflicts will this result in generally? I like it, but I'd
like to have some idea of whether it ends up being one of those
"really painful churn" things?

A couple of conflicts isn't an issue - they'll be trivial to fix. It's
the "this causes fifty silly conflicts" that I worry about, partly
because it then makes submaintainers inevitably do the wrong thing (ie
"I foresee an excessive amount of 'git rebase' rants next release").

Also, it looks like Google doesn't want this to happen. This whole
series was marked as spam for me.I'm not sure why, I don't see
anything odd that would trigger it, and DKIM and SPF both passed.
Maybe it's you, maybe it's Google, and maybe it's the infradead SRS
thing.

               Linus
