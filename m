Return-Path: <linux-arch+bounces-12400-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6D2AE08CE
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jun 2025 16:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96A1E168E31
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jun 2025 14:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3455B1EE7D5;
	Thu, 19 Jun 2025 14:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="GvXQchXE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC4618E02A
	for <linux-arch@vger.kernel.org>; Thu, 19 Jun 2025 14:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750343574; cv=none; b=B5IvEz8xZ9AjIUmkPGwtLA2OhO2X3AqnnSOi+45dI+9bi+62cEPXftPl1tvQqXfVhH62Kxm54Tg0vTrTqmOYtPmu8dTlHVGRF39kxEl56/USoaGp0/LSG7XlRL4bICWL8wjM2cRGxr6/PtlnA7L2NY+oLDT/2o+O+ePnkaWpRu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750343574; c=relaxed/simple;
	bh=f9InoU/zIyvqU5XW8HXwiQiJTHhL6rglkSPoRNyO+GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9HakoLgDp+i6rvwq5vTkdXuP9V/MvUA1SbZbW83189o98xFJPsqTemYXKUGvteYVsPmFIxPG/FEttru2sAtrOxgJa9w5opImzkJVdrD22xSWvQHxRh0zmy0UfGR3BREYaugRpCDOE4uiV1/qf5NrqC14iwE5U9BUVpXcccTadM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=GvXQchXE; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6facc3b9559so13571286d6.0
        for <linux-arch@vger.kernel.org>; Thu, 19 Jun 2025 07:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1750343571; x=1750948371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FOkFLnrJzZMHzNUSh+Y/TNE7FFzC3Os6Y5olMIbxKDs=;
        b=GvXQchXEl3AWSvPRrw9kXJ5LSbai5gl1iJhKUTYSPDFknEu6VwyoY8h95pL20AuqNf
         q48Rh2R3Wd2qq+OL5Gr4ePzvQzygkDd2piJ2NygAy0j5gNDXULMQSEYYrZn2t+hzTtVA
         jJSaW184dqfUvXzz0nQzQAjsySZ3fKDwskAxD2Sq16E/Za5iTDrx4ZiILwOGoVtkub6g
         2flxoGZnIcwVBXSkafstycMYf2P9A05Ah4a5ESeBE9wsXWC1MAGsDnPK10GwchPtKVwu
         fADkoVMcCZUdrpCoZYwilXSXTawvFh6MnqnFRwFkTsj9t6fR/uk2cYRlQZD4jIhtJuhK
         gG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750343571; x=1750948371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOkFLnrJzZMHzNUSh+Y/TNE7FFzC3Os6Y5olMIbxKDs=;
        b=mBvTiONZfpsSe30NUi2GKtlUyk21qpf0f1IQRAH5GEtfxhptmsWaT2m/4WwL+xw0g7
         zNSEy5EIro49J3Umr/Ph9jSP26p8n7yB1nvxoDzblMoK18uLqtWS7Vm1IHl8IiGA+8gK
         xdD5s0ERGVDILusritiXZeZdL2Y87zbk4LvuQ2Rrk3Le9kQAPODnE8lFGiaBcRBjF0ex
         gPG+/9AyHxrz/4658ZXlggAPMPETuicsYz8GvqZYJpm+t/a3XUIo6aiF4IP7NfZQFKgY
         cQ8tKy9z4+/Vwg7trCyCUrTxDV4w+K6UZfrC0ftlzM0+6y9s20nuTw8q0QZ6BZQYXdOJ
         6BHA==
X-Forwarded-Encrypted: i=1; AJvYcCWET3wv+r2M71S043U2qpAD3PouwRS9XXyAL20tN48Yt8xFarydeQ59UdjJHzARQkLtK1rHXu9xmLen@vger.kernel.org
X-Gm-Message-State: AOJu0YzMaRf7f+cHuBIa77Zf8eLXl6tSi0JHwDDLuz0iw28quN4QiiXX
	qTa7hy76SfRbV6mZ1Dpmfww98HenA6yEAz7azgwMNY8HK+kjKnhsllWi2D9XuArLWw==
X-Gm-Gg: ASbGncu6T1zP3I+OCogKvffQKe6eree7uzTE+MtFwpcNrAly2AndyJNRcnBxcQOV6sH
	t2U4WY5KzibkOXKZNe0AsuG6FSxYkg36/yaxiAyk/T4JVXFqDlyDGF8eNuK+ZSi1PjA/WYsggUu
	KGcYScdNXvWoOG7VRm9SjUgLO4Brif9ifvlwtof3I2MCR5qQqXnZHYOwZmFlkKzsS6IsLLKclL+
	MueQ8MlZr4VwnSc0eTVA4hrAGg9KnYFpCB2XXgqT1SRnmRlqQemnma3NQkaEOuyUvESIxcusJaO
	3z4/nEmJnSHQ2wLgbGoddoz//sTLoM0+M++zMgBGPCIwpEi38WyzjV5UKAVmOW4=
X-Google-Smtp-Source: AGHT+IHxQnCf/LYNTmc/z8v+E308ymSUGqUyJ6EPuGPk72H+rJoxyGsRQCNrsDtAHmaoQiC2Ino8aA==
X-Received: by 2002:a05:6214:19c2:b0:6e8:98a1:3694 with SMTP id 6a1803df08f44-6fb47772defmr361361336d6.8.1750343571359;
        Thu, 19 Jun 2025 07:32:51 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::9ca8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd095ca02bsm243696d6.125.2025.06.19.07.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 07:32:50 -0700 (PDT)
Date: Thu, 19 Jun 2025 10:32:47 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Thomas Haas <t.haas@tu-bs.de>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev, hernan.poncedeleon@huaweicloud.com,
	jonas.oberhauser@huaweicloud.com,
	"r.maseli@tu-bs.de" <r.maseli@tu-bs.de>
Subject: Re: [RFC] Potential problem in qspinlock due to mixed-size accesses
Message-ID: <6ac81900-873e-415e-b5b2-96e9f7689468@rowland.harvard.edu>
References: <cb83e3e4-9e22-4457-bf61-5614cc4396ad@tu-bs.de>
 <20250613075501.GI2273038@noisy.programming.kicks-ass.net>
 <aEwHufdehlQnBX7g@andrea>
 <9264df13-36db-4b25-b2c4-7a9701df2f4d@tu-bs.de>
 <aE-3_mJPjea62anv@andrea>
 <357b3147-22e0-4081-a9ac-524b65251d62@rowland.harvard.edu>
 <aFF3NSJD6PBMAYGY@andrea>
 <595209ed-2074-46da-8f57-be276c2e383b@tu-bs.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <595209ed-2074-46da-8f57-be276c2e383b@tu-bs.de>

On Thu, Jun 19, 2025 at 04:27:56PM +0200, Thomas Haas wrote:
> I support this endeavor, but from the Dartagnan side :).
> We already support MSA in real C/Linux code and so extending our supported
> Litmus fragment to MSA does not sound too hard to me.
> We are just missing a LKMM cat model that supports MSA.

To me, it doesn't feel all that easy.  I'm not even sure where to start 
changing the LKMM.\

Probably the best way to keep things organized would be to begin with 
changes to the informal operational model and then figure out how to 
formalize them.  But what changes are needed to the operational model?

Alan

