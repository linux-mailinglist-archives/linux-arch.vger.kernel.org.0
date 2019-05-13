Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 812D01B295
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2019 11:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbfEMJN1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 May 2019 05:13:27 -0400
Received: from mga07.intel.com ([134.134.136.100]:34770 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728616AbfEMJN1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 May 2019 05:13:27 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 02:13:26 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga007.jf.intel.com with ESMTP; 13 May 2019 02:13:21 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hQ71M-0007f0-23; Mon, 13 May 2019 12:13:20 +0300
Date:   Mon, 13 May 2019 12:13:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'christophe leroy' <christophe.leroy@c-s.fr>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
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
Message-ID: <20190513091320.GK9224@smile.fi.intel.com>
References: <20190510081635.GA4533@jagdpanzerIV>
 <20190510084213.22149-1-pmladek@suse.com>
 <20190510122401.21a598f6@gandalf.local.home>
 <daf4dfd1-7f4f-8b92-6866-437c3a2be28b@c-s.fr>
 <096d6c9c17b3484484d9d9d3f3aa3a7c@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <096d6c9c17b3484484d9d9d3f3aa3a7c@AcuMS.aculab.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 13, 2019 at 08:52:41AM +0000, David Laight wrote:
> From: christophe leroy
> > Sent: 10 May 2019 18:35
> > Le 10/05/2019 à 18:24, Steven Rostedt a écrit :
> > > On Fri, 10 May 2019 10:42:13 +0200
> > > Petr Mladek <pmladek@suse.com> wrote:

> > >> -	if (probe_kernel_address(ptr, byte))
> > >> +	if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
> > >>   		return "(efault)";
> 
> "efault" looks a bit like a spellling mistake for "default".

It's a special, thus it's in parenthesis, though somebody can be
misguided.

> > Usually, < PAGE_SIZE means NULL pointer dereference (via the member of a
> > struct)
> 
> Maybe the caller should pass in a short buffer so that you can return
> "(err-%d)"
> or "(null+%#x)" ?

In both cases it should be limited to the size of pointer (8 or 16
characters). Something like "(e:%4d)" would work for error codes.

The "(null)" is good enough by itself and already an established
practice..

-- 
With Best Regards,
Andy Shevchenko


