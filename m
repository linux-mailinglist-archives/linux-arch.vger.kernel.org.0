Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127D51C9860
	for <lists+linux-arch@lfdr.de>; Thu,  7 May 2020 19:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgEGRw3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 May 2020 13:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728277AbgEGRwZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 May 2020 13:52:25 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680FAC05BD09
        for <linux-arch@vger.kernel.org>; Thu,  7 May 2020 10:52:24 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k19so2352520pll.9
        for <linux-arch@vger.kernel.org>; Thu, 07 May 2020 10:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4xL4qCa/9s26UIoiJohUrv19oF5tpl0O53OyxD/cm4Y=;
        b=UhhAvyj4mHH32QJxuxUMjF/7MBpTbO2V7BzXH+drxAqVU1Cet9Uwtddk0wRtR7B3qy
         hW65DgYVJ3haf0tOlCt/8wA8qTXRjt59PXiOxIHBFtZ6u9y02NHuz92XK5UsZvX6yCgm
         hBznr/OMaqrgWU78lPZVqJ2RiFBL4KCAywVYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4xL4qCa/9s26UIoiJohUrv19oF5tpl0O53OyxD/cm4Y=;
        b=HXR2SkP7gs6fi9cK9rox9aWm7jgHxmtwzwdkwtZGZrsEWkgbOeW3feWfcF2mq69Hi7
         gTFutr/7wtiBa52knBIdr3clFzoTU01VhaJClJv9B1REVC9GM+GT5yC/A1Z/jyNk+HWb
         RjVz/azAnEwTp7+YQ3h9Na1g+apSa9NJVaul+KlWHbdIboHrGrRPlQSNqQh0nYH77lbi
         s41/7QUQCU09+oYLWUxQ4TpegUb8vouw+CtfLoQkRPHc5EGRl+gvbW+Ph5FGp8bP+HCx
         lpP1VNCpFRWA00K9kXSMagbfcVgIWHcmeaQM4WoC8WbrHPoL0amjuF8czi50+9C5Iy1U
         oXEg==
X-Gm-Message-State: AGi0PuYfkznPxtWdOM1Au/+i4XvaopxyTStjixyp/Q+p9wD2QkEZpbu1
        B711jEPv4EgPGglzvEFqyRHswQ==
X-Google-Smtp-Source: APiQypIVFtu6ODMFqOmgpEGjuYzYeF05nLLy0dHAEVQxFjNwaL8oFcXIYIe3aR74PKDZ/kzfd4UcUQ==
X-Received: by 2002:a17:902:5996:: with SMTP id p22mr13840844pli.153.1588873943970;
        Thu, 07 May 2020 10:52:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b9sm5429988pfp.12.2020.05.07.10.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 10:52:23 -0700 (PDT)
Date:   Thu, 7 May 2020 10:52:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     cl@linux.com, akpm@linux-foundation.org, arnd@arndb.de,
        willy@infradead.org, aquini@redhat.com, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: expand documentation over __read_mostly
Message-ID: <202005071052.1522C624@keescook>
References: <20200507161424.2584-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507161424.2584-1-mcgrof@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 07, 2020 at 04:14:24PM +0000, Luis Chamberlain wrote:
> __read_mostly can easily be misused by folks, its not meant for
> just read-only data. There are performance reasons for using it, but
> we also don't provide any guidance about its use. Provide a bit more
> guidance over its use.
> 
> Acked-by: Christoph Lameter <cl@linux.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
