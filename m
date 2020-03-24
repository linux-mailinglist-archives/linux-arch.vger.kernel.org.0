Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C26611905DB
	for <lists+linux-arch@lfdr.de>; Tue, 24 Mar 2020 07:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgCXGo4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Mar 2020 02:44:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46560 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgCXGo4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Mar 2020 02:44:56 -0400
Received: by mail-wr1-f68.google.com with SMTP id j17so16610464wru.13;
        Mon, 23 Mar 2020 23:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L4CW0rPtmeZubMea2TIqiT/A8GX+RXa02iEWUwJq80M=;
        b=vMqI1Te5IPhAlr1vwWuupx2adRh7j4RIR12j5Xh7fiKH2BXzvphS5cBC9R1ARPHX7y
         kol95YH8xZia6T590KQ4X1UXRFlsn53oEtigOswor/iKd3LqBz/SwiSHXq1FaaTmaz5t
         r3BmI1WzuaNCBRweXD8ilsi3DkYmC6FJDe+vivy6JAx5cKV+MzuFV/lhiCggFDqig3Gi
         mflJKgwnGl8N+06bYeEtaxnlFI17SWoZmmxTYHs+H+mHzk1adKMCAgPGmtqIaK0vC7bG
         7hzaOaGLPvIpWusRLutsKQrNLVS7lV7bdqwOkvJQkkel51Mh4mlYFBj2I4g/rpGKlFZt
         /GVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L4CW0rPtmeZubMea2TIqiT/A8GX+RXa02iEWUwJq80M=;
        b=g8wgPuMtowKGAhxXlRz6Tt2dZXomn72rzDyJXLdwJBVGiSMaEh4pbFSkFOlbMzJBUf
         SSrHMRwWgo4Yi/tL4zAHta633t+e1dC3dv1x7fq7rbR+vAyWbxDXfAT7/jrjKhHp+RIN
         jl2wxqQ8/rqEI/GUNvN5i3/XG1Km3Hvv0WKIHrDpMs2WZNSyELiBG/Znz9cumGbC0URc
         R+bVvUJDLaKf9T/W9QY+XKnw84xF2TJph9+LcKYoKfnFu0fJ/QRHQNm5leenyxSPgGrs
         2PcHKD+rwDCH4ilmLIBkjb/gILd4zQrzXc0BrXJ6+Hq4lyuRdWqDSYpoZCQ1VTxEZJJK
         /vcw==
X-Gm-Message-State: ANhLgQ20I1oFcomA9Trrjt3Yg7ZXPOFd/q15aV38DqIG+X2C6ygN/uEt
        hLU6OI6P2+1RHR+xLOGN8ps=
X-Google-Smtp-Source: ADFU+vvP8X1ym9IHuH0rddtq9/o73GmBGlSABNLr9RsYHQ5VSNahq+K6RIGwP8cILXwp4BuVH9C52w==
X-Received: by 2002:adf:e942:: with SMTP id m2mr16609442wrn.364.1585032293817;
        Mon, 23 Mar 2020 23:44:53 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7f9:7600:d82b:7ad8:892a:4798])
        by smtp.gmail.com with ESMTPSA id o9sm27801201wrw.20.2020.03.23.23.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 23:44:52 -0700 (PDT)
Date:   Tue, 24 Mar 2020 07:44:52 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Christopher Lameter <cl@linux.com>,
        Dennis Zhou <dennis@kernel.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] fix __percpu annotation in asm-generic
Message-ID: <20200324064452.zsnpcvihgeyegtmu@ltop.local>
References: <20191126200619.63348-1-luc.vanoostenryck@gmail.com>
 <alpine.DEB.2.21.1911271553560.16980@www.lameter.com>
 <20191127175350.GA52308@dennisz-mbp.dhcp.thefacebook.com>
 <20191127225432.ttwxm3hxtg5utfaz@ltop.local>
 <alpine.DEB.2.21.1911291808530.1365@www.lameter.com>
 <20191130000037.zsendu5pk7p75xqf@ltop.local>
 <20200324041347.GA186169@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324041347.GA186169@zx2c4.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 23, 2020 at 10:13:47PM -0600, Jason A. Donenfeld wrote:
> On Sat, Nov 30, 2019 at 01:00:37AM +0100, Luc Van Oostenryck wrote:
> > Note: it would be much much nicer to do all these type generic
> >       macros with '__auto_type' (only supported in GCC 4.9 IIUC
> >       and supported in sparse but it shouldn't be very hard to do)..
> 
> I'm curious to know if you know why we're not using __auto_type. Because
> we're stuck on gcc 4.6, or is there a more subtle reason?

I suppose. I don't remember having ever seen a discussion on the
subject (other than a simple remark like "it would be simpler
with __auto_type").

Mainline Sparse doesn't support it but I've a pending series for it
that seems to work well. 

-- Luc
