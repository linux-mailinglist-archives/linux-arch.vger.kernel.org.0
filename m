Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB6251978E
	for <lists+linux-arch@lfdr.de>; Fri, 10 May 2019 06:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfEJEcG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 May 2019 00:32:06 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43684 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfEJEcG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 May 2019 00:32:06 -0400
Received: by mail-pl1-f196.google.com with SMTP id n8so2192650plp.10;
        Thu, 09 May 2019 21:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xvneL+tleAZug+cm73ok0sRVVSDLg417J9gTpEjzm0Y=;
        b=OFGOE2NwOn/bcY8miPOcXwpkHA80Ku8G4fyzOGykVhmR/QDaMsnCcwbIDimS7JTF5x
         gvMg+htASqUGwslWKLMbU1xXdsQaVUcA/xPqXJ0j45BYvpJ3onYF5mDvzaoz3gA3C77B
         ++l12pVN+QFnZjgx39cid1yMH+P3KT0xaTRuupjJwhqpQ78pa3bVqh+Gj22blHzFubzH
         YtdQ7BQvuXX8czCJXHl9ref8MygU9ec9G0beZY9SNC55RzYgkGmMTDmHFBliUjOnie/Y
         rT9nhRDFk346t/w2nxRdrAq6xrkYiBzWcghocJe6EOAGwJeDfMlTeLC4nNAuKqMZeMcw
         bPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xvneL+tleAZug+cm73ok0sRVVSDLg417J9gTpEjzm0Y=;
        b=Y0UEUUxtaCQH2cnMxENfztawyFlKdgExduujyJU56aewSxayhN6h2+Iik42pZ4fYfL
         G0USklTwMFTE7STym7HUymEKZ51r+7KgYpQUhl96Poao7bgbSIx+gaie83KPEenjx2i/
         u4fCjXrxKqHoJnIpD/9lYMHtE/dTxHElFr/wl5UnIvlIydVIgF7vTwTuA0fuei6V+www
         9MQrgRc6sqiPzieAZ9uWCMSpjV5GU63lnIysNmRiQ1x1fL5Z1WI6UC0GdV+UbrZWVZFu
         7oWzQ4bYZnr+1U383eFNEKF4Y85JTOfw3n5h729ZM9fRvBhR7bLq9++uMTQa5Lx4icr7
         hJtQ==
X-Gm-Message-State: APjAAAX6vavaKS69kYb9/SY2+CDXGY43dwl+lDR2ITe7EpIbVcCsCRPz
        iBW8A0K2e2ZGorGmiM7w1zY=
X-Google-Smtp-Source: APXvYqzCVqQG81jyDsA4pwg3oVltor0yDbhImtQRMizI91ol50Lus0a+020M12H8AeI0dti/GS3zRA==
X-Received: by 2002:a17:902:10c:: with SMTP id 12mr10524545plb.61.1557462725544;
        Thu, 09 May 2019 21:32:05 -0700 (PDT)
Received: from localhost ([39.7.15.25])
        by smtp.gmail.com with ESMTPSA id y17sm5555133pfb.161.2019.05.09.21.32.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 21:32:03 -0700 (PDT)
Date:   Fri, 10 May 2019 13:32:00 +0900
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
Message-ID: <20190510043200.GC15652@jagdpanzerIV>
References: <20190509121923.8339-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509121923.8339-1-pmladek@suse.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On (05/09/19 14:19), Petr Mladek wrote:
> 1. Report on Power:
> 
> Kernel crashes very early during boot with with CONFIG_PPC_KUAP and
> CONFIG_JUMP_LABEL_FEATURE_CHECK_DEBUG
> 
> The problem is the combination of some new code called via printk(),
> check_pointer() which calls probe_kernel_read(). That then calls
> allow_user_access() (PPC_KUAP) and that uses mmu_has_feature() too early
> (before we've patched features). With the JUMP_LABEL debug enabled that
> causes us to call printk() & dump_stack() and we end up recursing and
> overflowing the stack.

Hmm... hmm... PPC does an .opd-based symbol dereference, which
eventually probe_kernel_read()-s. So early printk(%pS) will do

	printk(%pS)
	 dereference_function_descriptor()
	  probe_kernel_address()
	   dump_stack()
	    printk(%pS)
	     dereference_function_descriptor()
	      probe_kernel_address()
	       dump_stack()
	        printk(%pS)
	         ...

I'd say... that it's not vsprintf that we want to fix, it's
the idea that probe_kernel_address() can dump_stack() on any
platform. On some archs probe_kernel_address()->dump_stack()
is going nowhere:
 dump_stack() does probe_kernel_address(), which calls dump_stack(),
 which calls printk(%pS)->probe_kernel_address() again and again,
 and again.

	-ss
