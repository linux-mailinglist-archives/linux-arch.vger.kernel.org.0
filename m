Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 806D91C07A
	for <lists+linux-arch@lfdr.de>; Tue, 14 May 2019 04:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfENCHf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 May 2019 22:07:35 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42941 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfENCHf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 May 2019 22:07:35 -0400
Received: by mail-pl1-f195.google.com with SMTP id x15so7389940pln.9;
        Mon, 13 May 2019 19:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TUW58sFUl5sYOk3396X1MJdln3VeH0EXozxImmU59vw=;
        b=gDzV41z701QnCrQ26V0bq4z6xWTHENKXtePpErSx1cTFZAEnR170Cb3GIh6X6MaWvS
         P86mF/lBRPJUDD0wchUSehkIB5xvrpeuqlBa3x2Vho248Nn/RkVDrf1bXASF+h6UKMN4
         RJw+91n48gNTDuIgc4nbPEe+W1cxRXTb+DWKeIovw8s8/EnknXE17L/40Sd6A2Ubbr5c
         mWCcTIy0CdYWj6taw53+CmqUKawbwZcEhJArjMmEt6X9vDDg49TOvQtWuiBMVFdi+mON
         IPNk5ELNC1d9yajDGEoP1a7uD/eSigryhXScvyM69k3K7CMtduUWmvSmvMIQ6zmk60J0
         pPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TUW58sFUl5sYOk3396X1MJdln3VeH0EXozxImmU59vw=;
        b=OQXl/Ci0QDUwGmKmNrDFYUJTh+xKTkbDdO/K8RHRF3J8ccuola8H9M8lORL5vCvmby
         AL6SP7t760ZYIajguGOoMoRZEAgGAAy2lgfEy5rRNHOAI9Cp9MGNdSKCzNtdIW95pbo1
         hmKz/4DdnnSmXTtIOy47PCrbbV/aDMGYpTgJHsB+24fV62hpO7h/ayZ+hxyv3Th8A0oS
         qFxgmnWZQdqHhDTrfKCU5I1KuDmO6ADOcMWyx85fqT8bdhIW09gsKIoLugaFXxCEgXjJ
         m1UIizGv1sNmTpWwCOXiJyySqCQjh029Q5wWo9c4kKocvsuCK16dwRZ2+wGc9dUgNe8L
         Z7mw==
X-Gm-Message-State: APjAAAXYuEx1TTifdK+TLYFbepgfkJ0cYCKzxslQC+6+Y4ixXft3i/xi
        5kbk6GwLJPO/wmepgsizJhs=
X-Google-Smtp-Source: APXvYqyCY0Kzi1kXb0vmv87aGVQQILnCJJ8qRJqL49F8s8Dds7JPB7O9ESBZIffOVdyOAeqexsF5/w==
X-Received: by 2002:a17:902:108a:: with SMTP id c10mr35439629pla.48.1557799654316;
        Mon, 13 May 2019 19:07:34 -0700 (PDT)
Received: from localhost ([39.7.55.172])
        by smtp.gmail.com with ESMTPSA id v64sm19993908pfv.106.2019.05.13.19.07.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 19:07:33 -0700 (PDT)
Date:   Tue, 14 May 2019 11:07:30 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Laight <David.Laight@aculab.com>,
        'christophe leroy' <christophe.leroy@c-s.fr>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Russell Currey <ruscur@russell.cc>,
        Stephen Rothwell <sfr@ozlabs.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] vsprintf: Do not break early boot with probing addresses
Message-ID: <20190514020730.GA651@jagdpanzerIV>
References: <20190510081635.GA4533@jagdpanzerIV>
 <20190510084213.22149-1-pmladek@suse.com>
 <20190510122401.21a598f6@gandalf.local.home>
 <daf4dfd1-7f4f-8b92-6866-437c3a2be28b@c-s.fr>
 <096d6c9c17b3484484d9d9d3f3aa3a7c@AcuMS.aculab.com>
 <20190513091320.GK9224@smile.fi.intel.com>
 <20190513124220.wty2qbnz4wo52h3x@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513124220.wty2qbnz4wo52h3x@pathway.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On (05/13/19 14:42), Petr Mladek wrote:
> > The "(null)" is good enough by itself and already an established
> > practice..
> 
> (efault) made more sense with the probe_kernel_read() that
> checked wide range of addresses. Well, I still think that
> it makes sense to distinguish a pure NULL. And it still
> used also for IS_ERR_VALUE().

Wouldn't anything within first PAGE_SIZE bytes be reported as
a NULL deref?

       char *p = (char *)(PAGE_SIZE - 2);
       *p = 'a';

gives

 kernel: BUG: kernel NULL pointer dereference, address = 0000000000000ffe
 kernel: #PF: supervisor-privileged write access from kernel code
 kernel: #PF: error_code(0x0002) - not-present page


And I like Steven's "(fault)" idea.
How about this:

	if ptr < PAGE_SIZE		-> "(null)"
	if IS_ERR_VALUE(ptr)		-> "(fault)"

	-ss
