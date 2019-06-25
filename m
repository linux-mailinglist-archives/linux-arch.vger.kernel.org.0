Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36BDC55868
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2019 22:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfFYUIK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Jun 2019 16:08:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44963 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfFYUIJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jun 2019 16:08:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id n2so9470413pgp.11
        for <linux-arch@vger.kernel.org>; Tue, 25 Jun 2019 13:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QTBYIsHI8zTMLEyvwtX6vz4jgxzEbNHxNVg1zzv+uWs=;
        b=GFD4YL7rkGte7dY9QecMGQVpBAuunM7M4kNB4I4J4HToFkTT6kzO4mzdswjpF7r040
         S9GAX102W+LhmXZ4yS3Q53lWrLv0qMrY09Rn9OEGQf3DWq6oOD93s6yEIZi9ZSY/8mOE
         tHZM21Pp0ucGbM3ZzgASmEvwhutvcH3mQAzmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QTBYIsHI8zTMLEyvwtX6vz4jgxzEbNHxNVg1zzv+uWs=;
        b=JdIhM7D9SzTTGWUyPEOFQluPZ9aog4Ysb7tfwVSNqVMyObgQkQiGpFd1DKtCLKwq5R
         NGznk3ySUp8IbSaBUXa3fb9PPQOBIolcDG8vbQc5TVHxE6yyAMYHBZWgX7WDWe6lIO35
         WDR8zSG6C36IJHVvn0pjkFC7MqWsW0EmrimYxWtcsfj4nmt4vTa4cOzsZCtfhn4/oF9l
         mXlMIg7Qr6ilOk0l3DlffXBBFngffnyCqU6GbBvECE6tZYvL8A9sbUPhBI7OpJL6HTeX
         5jLT+KIIjwxAn4QcdqIeeLBlOD2zeWT8BX2wNk5z0n7Zb+YfdbrmwAebEAtRH2ASk/RG
         kLMw==
X-Gm-Message-State: APjAAAUNYEsOtryBkS4nVMYGPVfLuEEyMAW+JxhGg9dMc3jd+yp5DaDr
        HrCmSQN58ujwRfZgOYpSOSAnXg==
X-Google-Smtp-Source: APXvYqz4wFwSx2u/z3fzZResgKJfp4GOCsNFxJX8Qh/tN021DReuR4LVm+X37zl/gnxfdS1yHAMYkA==
X-Received: by 2002:a65:62cb:: with SMTP id m11mr25236218pgv.27.1561493289120;
        Tue, 25 Jun 2019 13:08:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j24sm4271354pgg.86.2019.06.25.13.08.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Jun 2019 13:08:08 -0700 (PDT)
Date:   Tue, 25 Jun 2019 13:08:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-api@vger.kernel.org, kernel-hardening@lists.openwall.com,
        linux-x86_64@vger.kernel.org, linux-arch@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Carlos O'Donell <carlos@redhat.com>
Subject: Re: Detecting the availability of VSYSCALL
Message-ID: <201906251131.419D8ACB@keescook>
References: <87v9wty9v4.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9wty9v4.fsf@oldenburg2.str.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 25, 2019 at 05:15:27PM +0200, Florian Weimer wrote:
> Should we try mapping something at the magic address (without MAP_FIXED)
> and see if we get back a different address?  Something in the auxiliary
> vector would work for us, too, but nothing seems to exists there
> unfortunately.

It seems like mmap() won't even work because it's in the high memory
area. I can't map something a page under the vsyscall page either, so I
can't distinguish it with mmap, mprotect, madvise, or msync. :(

-- 
Kees Cook
