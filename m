Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B41E1C7DAB
	for <lists+linux-arch@lfdr.de>; Thu,  7 May 2020 01:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgEFXDZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 May 2020 19:03:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbgEFXDZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 6 May 2020 19:03:25 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 398182145D;
        Wed,  6 May 2020 23:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588806204;
        bh=XcKljOyA8MI70ejLn0nQwtirIILJp1QajO5LmILJmlg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wyt/JGZoLBoCyrBbn+nfKaptsftweK+J/hSN/lanGug2dLve6x9IIG1O6u0eohq7L
         g4TBx58wLXTZ9ZQQB9ddeTSyd/ZG5lVk4uhkoH+gu/r1TWmz6j62pfp9AeV6LqRpFR
         L7TA0Un44Wj8o//D5Mkep7vCrBa8XeG24QfzeOpw=
Received: by mail-ed1-f54.google.com with SMTP id r7so3603802edo.11;
        Wed, 06 May 2020 16:03:24 -0700 (PDT)
X-Gm-Message-State: AGi0PuadTxLMVe5qsoznW672L/ylmB1W/sTF9Fi2pIT6iH4DXdrzZVMN
        eQhyWSQKvK6G8OG3ov2EqLtr2ut+yUR4DoxNWEs=
X-Google-Smtp-Source: APiQypL7jasVVzwLhx3EaVL/2cJEk9MJtHeXT6qkCc1Y5SzHENoGQP9owkfX68fn1CyN/mdLVs9MduopS6s761TG+e0=
X-Received: by 2002:a50:d6d0:: with SMTP id l16mr9650852edj.317.1588806202552;
 Wed, 06 May 2020 16:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180508181924.19939-1-mcgrof@kernel.org>
In-Reply-To: <20180508181924.19939-1-mcgrof@kernel.org>
From:   Luis Chamberlain <mcgrof@kernel.org>
Date:   Wed, 6 May 2020 17:03:15 -0600
X-Gmail-Original-Message-ID: <CAB=NE6WnO+6Mn-t9coVHKSVY5iNpTcb+VGCAfBJWrwj3jNNAKA@mail.gmail.com>
Message-ID: <CAB=NE6WnO+6Mn-t9coVHKSVY5iNpTcb+VGCAfBJWrwj3jNNAKA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: expland documentation over __read_mostly
To:     Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Christopher Lamenter <cl@linux.com>,
        Rafael Aquini <aquini@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Waiman Long <longman@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>, joel.opensrc@gmail.com,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 8, 2018 at 12:19 PM Luis R. Rodriguez <mcgrof@kernel.org> wrote:
>
> __read_mostly can easily be misused by folks, its not meant for
> just read-only data. There are performance reasons for using it, but
> we also don't provide any guidance about its use. Provide a bit more
> guidance over it use.
>
> Acked-by: Christoph Lameter <cl@linux.com>
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>

After 2 years, this patch was never applied... and so people can
easily keep misusing this. I'll resend now.

  Luis
> ---
>  include/linux/cache.h | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/cache.h b/include/linux/cache.h
> index 750621e41d1c..4967566ed08c 100644
> --- a/include/linux/cache.h
> +++ b/include/linux/cache.h
> @@ -15,8 +15,16 @@
>
>  /*
>   * __read_mostly is used to keep rarely changing variables out of frequently
> - * updated cachelines. If an architecture doesn't support it, ignore the
> - * hint.
> + * updated cachelines. Its use should be reserved for data that is used
> + * frequently in hot paths. Performance traces can help decide when to use
> + * this. You want __read_mostly data to be tightly packed, so that in the
> + * best case multiple frequently read variables for a hot path will be next
> + * to each other in order to reduce the number of cachelines needed to
> + * execute a critial path. We should be mindful and selective of its use.
> + * ie: if you're going to use it please supply a *good* justification in your
> + * commit log.
> + *
> + * If an architecture doesn't support it, ignore the hint.
>   */
>  #ifndef __read_mostly
>  #define __read_mostly
> --
> 2.17.0
>
