Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0DF19C829
	for <lists+linux-arch@lfdr.de>; Thu,  2 Apr 2020 19:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389735AbgDBRig (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Apr 2020 13:38:36 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36332 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389561AbgDBRig (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Apr 2020 13:38:36 -0400
Received: by mail-pj1-f66.google.com with SMTP id nu11so1786568pjb.1
        for <linux-arch@vger.kernel.org>; Thu, 02 Apr 2020 10:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RFmh29f6b4RBzzdEqK+shU1sG1CQYZR2pnjNQ4GHtz4=;
        b=nZ1tW5cdLTnrJHaCLa8YsIRPpPlRPFpL0uEDPZq5C6IXi8B6PIPo0V44IWP7UdveOK
         n8a3uVYEAnP6svRPOtPbYL0aA5JwtdXCSFnOxGztaGHqGpIZK4nPVqLn4Y8SLax0u0Vu
         OIiaVcpyAYJwCEhpCFe9d5+dT+2UWC9a1H+y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RFmh29f6b4RBzzdEqK+shU1sG1CQYZR2pnjNQ4GHtz4=;
        b=UBX5e8xhW3q7Xw1PbY/bLhtaAR9MgioapZjc8CkVlS/lhhY+eal4kOniquyn52Jzs3
         6qWOA4Q0qFjjl2F/KseXMcqdySUsjmd81w0b65vA7MF869PJRXqMift4G8FILbM66Urj
         zUGZKl0ffm4/J0NtZfieKlw4bP81CvTuAP74zrfqTJ0OczioH42yGsTuom83lht+t/wL
         oX7sYLf/wlDASEfSIZBQKgIvtLwmjLkZSVTiWXMSpO4MI/1WD3JuKJAjdqXFDj410OR4
         IZDx8WXNEJR6gS+0neEQmrzAIyB1XVJASN9I0OYOAqG0/tVhKOCpP5bTD/2xnU/etTLH
         oMDw==
X-Gm-Message-State: AGi0PuYxK25J/9QStKH7nrRYxe0ySNlhQJHPLtzKyY9dyhOMGy4tHAKi
        rQ/DtGf405O+9WegUNx0LiY95VTh9Iw=
X-Google-Smtp-Source: APiQypLF9RC8sBLfTXy7MiRa5PFnHgJKJWkxNSBkHJjYskdTsqaZauwH5Q8uNxCHLFh5f+ETA6Q6wg==
X-Received: by 2002:a17:90b:3653:: with SMTP id nh19mr5043955pjb.154.1585849115305;
        Thu, 02 Apr 2020 10:38:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h71sm3711857pge.32.2020.04.02.10.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 10:38:33 -0700 (PDT)
Date:   Thu, 2 Apr 2020 10:38:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, airlied@linux.ie,
        daniel@ffwll.ch, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH RESEND 1/4] uaccess: Add user_read_access_begin/end and
 user_write_access_begin/end
Message-ID: <202004021035.573BBBE9AA@keescook>
References: <27106d62fdbd4ffb47796236050e418131cb837f.1585811416.git.christophe.leroy@c-s.fr>
 <20200402162942.GG23230@ZenIV.linux.org.uk>
 <67e21b65-0e2d-7ca5-7518-cec1b7abc46c@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e21b65-0e2d-7ca5-7518-cec1b7abc46c@c-s.fr>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 02, 2020 at 07:03:28PM +0200, Christophe Leroy wrote:
> > What should we do about arm and s390?  There we want a cookie passed
> > from beginning of block to its end; should that be a return value?
> 
> That was the way I implemented it in January, see
> https://patchwork.ozlabs.org/patch/1227926/
> 
> There was some discussion around that and most noticeable was:
> 
> H. Peter (hpa) said about it: "I have *deep* concern with carrying state in
> a "key" variable: it's a direct attack vector for a crowbar attack,
> especially since it is by definition live inside a user access region."

I share this concern -- we want to keep user/kernel access as static as
possible. It should be provable with static analysis, etc (e.g. objtool
does this already for x86).

Since this doesn't disrupt existing R+W access, I'd prefer the design of
this series as-is.

-- 
Kees Cook
