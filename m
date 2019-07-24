Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2566736D9
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2019 20:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfGXSpz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jul 2019 14:45:55 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39602 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfGXSpz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jul 2019 14:45:55 -0400
Received: by mail-qt1-f193.google.com with SMTP id l9so46498526qtu.6
        for <linux-arch@vger.kernel.org>; Wed, 24 Jul 2019 11:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DJ+4O/aME8mxWsBOK/hkAuIS+vdRAGZALWdoZ5g0Ta4=;
        b=Rm6YHvoNZRDQjxxSjBVeakB3SzWeohrifsuK1TBQmXrYgP2URwhmgfoCdyR0LlgTY5
         dFxTYLxyuvWx9w2MB94VYd1TjtD1nUSAS1kKBt/ihZMFNRPIaXEJKlv61dTZZyHBmKoE
         +EFHkVmM7NknERHlp5Dy3LSndHMfI+0+qiF+7GZwtlj+7/3KMJpAxs6a7B6/Xaq1MJKo
         OevFK5AxPhev4kgZNni4QltSJj03gq4KVjBtKiGbqQceqjTrL8CyIyMgJ569rYYyhucs
         IXzN1FaOO8BLi+Avg+koyqkj6BRR47b2+K29yfVIg2zgz2+fM15lIXLORgCk7Ow+OZBs
         F0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DJ+4O/aME8mxWsBOK/hkAuIS+vdRAGZALWdoZ5g0Ta4=;
        b=c1JThmQVgYVnkli6mCmHm8gGRaO27b23eO7DzYsDJ9BFd1kbuXedVVj6YVIbCy2fod
         cxR/T4vNDC4g7bSRP/v88bLv9y5COtHqBXivZhHCVZHrTNXquS1oBhkoFHJbamMPNJxp
         qagsWI+yQ9GsVFrgjw8VAw8Cdg1WqUp9jYZOrfmNf/0pdXQ146upRyt+TKMhHVKg84cx
         foj0sTGCctIMJKsEsfzQDIKhkySzWvwfzeqsMWGdCCPh7xfi4gfWsVN7sQYdmKxg52gL
         sNWGTHUkglJ88n/eOPfpuZynDG+FBE7qd4QV+VCuz/3qQ8/gNCecgwaGaRxc0+vX0fDS
         4HNA==
X-Gm-Message-State: APjAAAWA2AKaPCYQGLKpwVlquMkq2/GnLQU1NGhwjVd5LvDaX3Wige9x
        rG6HGMc39V3wkQ+1V70537fWfQ==
X-Google-Smtp-Source: APXvYqw7TtMYWD5qzkFU/pK7j6Pol2Ofw8wMHbLq51U3ZQ9VZA3tj6I+JTPr2xFAMFuHq36H42pRHg==
X-Received: by 2002:a0c:d91b:: with SMTP id p27mr59380012qvj.236.1563993954400;
        Wed, 24 Jul 2019 11:45:54 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f68sm21117654qtb.83.2019.07.24.11.45.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 11:45:53 -0700 (PDT)
Message-ID: <1563993952.11067.15.camel@lca.pw>
Subject: Re: [PATCH] asm-generic: fix -Wtype-limits compiler warnings
From:   Qian Cai <cai@lca.pw>
To:     David Howells <dhowells@redhat.com>
Cc:     akpm@linux-foundation.org, davem@davemloft.net, arnd@arndb.de,
        jakub@redhat.com, ndesaulniers@google.com, morbo@google.com,
        jyknight@google.com, natechancellor@gmail.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 24 Jul 2019 14:45:52 -0400
In-Reply-To: <31573.1563954571@warthog.procyon.org.uk>
References: <1563914986-26502-1-git-send-email-cai@lca.pw>
         <31573.1563954571@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2019-07-24 at 08:49 +0100, David Howells wrote:
> Qian Cai <cai@lca.pw> wrote:
> 
> > Fix it by moving almost all of this multi-line macro into a proper
> > function __get_order(), and leave get_order() as a single-line macro in
> > order to avoid compilation errors.
> 
> The idea was that you could compile-time initialise a global variable with
> get_order():
> 
> 	int a = get_order(SOME_MACRO);
> 
> This is the same reason that ilog2() is a macro:
> 
> 	int a = ilog2(SOME_MACRO);
> 
> See the banner comment on get_order():
> 
>  * This function may be used to initialise variables with compile time
>  * evaluations of constants.
> 
> If you're moving the constant branch into __get_order(), an inline function,
> then we'll no longer be able to do this and you need to modify the comment
> too.  In fact, would there still be a point in having the get_order() macro?
> 
> Also, IIRC, older versions of gcc see __builtin_constant_p(n) == 0 inside an
> function, inline or otherwise, even if the passed-in argument *is* constant.

I have GCC 8.2.1 which works fine.

# cat const.c 
#include <stdio.h>

static int i = 0;

static inline void check()
{
	if (__builtin_constant_p(i))
		printf("i is a const.\n");
}

void main()
{
	check();
}

# gcc -O2 const.c -o const

# ./const 
i is a const.
