Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99AE1F3DBF
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jun 2020 16:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgFIOQ3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Jun 2020 10:16:29 -0400
Received: from foss.arm.com ([217.140.110.172]:43088 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730095AbgFIOQZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 9 Jun 2020 10:16:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01A661FB;
        Tue,  9 Jun 2020 07:16:24 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD27A3F66F;
        Tue,  9 Jun 2020 07:16:22 -0700 (PDT)
Date:   Tue, 9 Jun 2020 15:16:20 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     linux-man@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 5/6] prctl.2: Add PR_PAC_RESET_KEYS (arm64)
Message-ID: <20200609141620.GC25945@arm.com>
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
 <1590614258-24728-6-git-send-email-Dave.Martin@arm.com>
 <1084d017-54f3-475c-be1b-aabc801d9a71@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1084d017-54f3-475c-be1b-aabc801d9a71@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 09, 2020 at 01:36:42PM +0200, Michael Kerrisk (man-pages) wrote:
> Hello Dave,
> 
> I've applied this patch (manually, because 4/6 is not yet applied).
> I have a question below.
> 
> On 5/27/20 11:17 PM, Dave Martin wrote:
> > Add documentation for the PR_PAC_RESET_KEYS ioctl added in Linux
> > 5.0 for arm64.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Amit Daniel Kachhap <amit.kachhap@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > 
> > ---
> > 
> > Since v1:
> > 
> >  * Clarify explicitly that PR_PAC_RESET_KEYS is redundant when combined
> >    with execve().
> > 
> >  * Move error condition details into the prctl description, to avoid
> >    excessive duplication while keeping keeping related pieces of text
> >    closer together.
> > 
> >  * In lieu of having a separate man page to cross reference for detailed
> >    guidance, cross-reference the kernel documentation.
> > 
> >  * Add safety warning.  This is deliberately vague, pending ongoing
> >    discussions with libc folks.
> > ---
> >  man2/prctl.2 | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 80 insertions(+)
> > 
> 
> [...]
> 
> > +.IP
> > +.B Warning:
> > +Because the compiler or run-time environment
> > +may be using some or all of the keys,
> > +a successful
> 
> Things got a bit garbled here. I think the next few lines should have been 
> at the end.
> > +.IP
> > +For more information, see the kernel source file
> > +.I Documentation/arm64/pointer\-authentication.rst
> > +.\"commit b693d0b372afb39432e1c49ad7b3454855bc6bed
> > +(or
> > +.I Documentation/arm64/pointer\-authentication.txt
> > +before Linux 5.3).
> > +.B PR_PAC_RESET_KEYS
> > +may crash the calling process.
> > +The conditions for using it safely are complex and system-dependent.
> > +Don't use it unless you know what you are doing.
> 
> I applied the following change after your patch; is it okay?
> 
>  .IP
>  .B Warning:
>  Because the compiler or run-time environment
>  may be using some or all of the keys,
>  a successful

Looks fine, execpt that I think you need to move the

	.B PR_PAC_RESET_KEYS

line here also.

Thanks
---Dave

> +may crash the calling process.
> +The conditions for using it safely are complex and system-dependent.
> +Don't use it unless you know what you are doing.
>  .IP
>  For more information, see the kernel source file
>  .I Documentation/arm64/pointer\-authentication.rst
> @@ -1020,9 +1023,6 @@ For more information, see the kernel source file
>  .I Documentation/arm64/pointer\-authentication.txt
>  before Linux 5.3).
>  .B PR_PAC_RESET_KEYS
> -may crash the calling process.
> -The conditions for using it safely are complex and system-dependent.
> -Don't use it unless you know what you are doing.
>  .\" prctl PR_SET_PDEATHSIG
>  .TP
>  .BR PR_SET_PDEATHSIG " (since Linux 2.1.57)"
> 

[...]
