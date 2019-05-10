Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCB3619A08
	for <lists+linux-arch@lfdr.de>; Fri, 10 May 2019 10:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfEJIv0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 May 2019 04:51:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38437 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfEJIvZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 May 2019 04:51:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id j26so2691135pgl.5;
        Fri, 10 May 2019 01:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gL9lx8kVDxGBvBDPY9ofQJR5Y2JHIPbQZd/gZRgawmg=;
        b=OQ92lVBs9QTSEI+m13cYS13d0/0pR5CaNigXu41OihDpr1PXII9RPeev5oofTgQeT5
         tzWHJPRVksgdeMEmBLdiSTmw4aZ99QBK202mO1y5D2SV0yiM3Cmc65kPoSn6WK9ve+i2
         WzqzuZYDee8pllOGV+ZWYu7kIzym6K/megZTIsgn4boqc+YuBf7yXDKoLx9u+TaZWyV2
         ZbcSMXOvVQc6P3GzOMmbTs9sYDxMgIgS1fnWySOEHFZm2HYcbj0hTfX34BxN7BqI5flW
         pYyXsBrLLUrYXD7hLLP9GLtBgvme95OwYDZUyt+bOFS+sDESyDFsKE8SsSvIe509KoOj
         CxcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gL9lx8kVDxGBvBDPY9ofQJR5Y2JHIPbQZd/gZRgawmg=;
        b=qyF3t/6dQwu4AAD5N7q2T2UJMb/gmMBwSS38sUAhZ0uo9fAi0V6cn/30tgd3ql/N8I
         xJjRd6wqCB/mPDro0iOvpf/75G3Mi6eP9FIQJJprQDRGlnEDIQJiSHIXKNq+h3h1McA/
         flxvQWj/mXCp8dKQPK2ZQG9BADMeMPBacdIGtBQqufLG2raVwWbGxrYEa8FM1Ed37AYl
         AcC53X3sq1O+ebWC4xYA9sOMVAC7eiHZG63Gyci7A09ljmJjUCeRjV1snNJ3O+32Q5uv
         n0UK8qhaKNJTZZShCn59QBD7u6cdpFsicyVmaVfsXHD+gWPJVJxQTr3GBBTN8NimQ19r
         Pr5w==
X-Gm-Message-State: APjAAAVz30OIOzaLLPVlPp+uSbe/n+fw/hKPK234p4aofqVudwfUm0qY
        acVxnLGUJ36rRuv7wYQ96n8=
X-Google-Smtp-Source: APXvYqz73bpUIGnNQKzUcF4Kv0BOgEYh18rjzWzVuPqLZqaSK693aC3PMkYpkGDq0RRylFJyRjOoKw==
X-Received: by 2002:a63:6f0b:: with SMTP id k11mr11887557pgc.342.1557478284993;
        Fri, 10 May 2019 01:51:24 -0700 (PDT)
Received: from localhost ([39.7.15.25])
        by smtp.gmail.com with ESMTPSA id b63sm8458414pfj.54.2019.05.10.01.51.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 01:51:23 -0700 (PDT)
Date:   Fri, 10 May 2019 17:51:21 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, Russell Currey <ruscur@russell.cc>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Stephen Rothwell <sfr@ozlabs.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] vsprintf: Do not break early boot with probing addresses
Message-ID: <20190510085121.GA17632@jagdpanzerIV>
References: <20190510081635.GA4533@jagdpanzerIV>
 <20190510084213.22149-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510084213.22149-1-pmladek@suse.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On (05/10/19 10:42), Petr Mladek wrote:
[..]
> Fixes: 3e5903eb9cff70730 ("vsprintf: Prevent crash when dereferencing invalid pointers")
> Signed-off-by: Petr Mladek <pmladek@suse.com>

FWIW
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
