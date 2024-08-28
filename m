Return-Path: <linux-arch+bounces-6713-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB69896284B
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 15:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69574281AC2
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 13:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187B617A922;
	Wed, 28 Aug 2024 13:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6nuSt4a"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DAF178CE8;
	Wed, 28 Aug 2024 13:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724850664; cv=none; b=PrhQDNdVBgxQ9PcuLKl5xfBKMrHl/V0j9c4vS7Eur1OY96rIsqri3SpRZuzVlas4NBHyOzSLSMzN+f8YPhIQKlmjgTGKOJAbVPltc86dkMHIzFZf7RSc+1hk9BQ298eCb3i/dtmwH9UiACIP6a8YQWvaf69kEjgbAAwsjXF8UnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724850664; c=relaxed/simple;
	bh=l1xLvjQcE5InG/jp/rGdjPz/Oo9CGJZ/7aJnxn+LySM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Dw+aRTF+jLW5xZ5RCFVxhfKb0/dyflhqN63yjlefSZatzyuE/uNDqzAozzB8zpbsRndq8fz75+XeYrtEgh5kpcaDu52WfzRYtRGx0bjYaSxzBmNd0IsF/cbulc54ngl53W20bYOgnYpQpBt/WKOoiLiwQqVKs5RlBPtMwSA7jw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6nuSt4a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD4CC98EF0;
	Wed, 28 Aug 2024 13:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724850663;
	bh=l1xLvjQcE5InG/jp/rGdjPz/Oo9CGJZ/7aJnxn+LySM=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=q6nuSt4aqXjhQEMwYK2m7HsZnf/IQicSCSdaB9KRJGp9/2vRLawQ+/UbDWgCYbyXl
	 +vVG4B6Z8LhOrrlwE4i2fDDkAcDqAlnRHFLTuNwwwlZe+rWayD8gEGSrvwtGoXZ3rI
	 TRp274x0OvfwhfnAqnf4hdFYEa6efOwVpjZjCF77uMVrtESunpdEGvwsh15RY5Ja2e
	 4h602f7/0yqmiuoCsX4WkD02x18DWe+p0KWNe2LmOPVamDGg9ZzrAxYmk4J4I7YP+T
	 Q6oA8HXJo9bK4Q0gpWdLJ7zFHEzPEEzSbEv1wwWTvrGqKwWc6ofy99JkqURVxTqqra
	 CPtGGg1Jz2w8w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 112C5CE1697; Wed, 28 Aug 2024 06:11:03 -0700 (PDT)
Date: Wed, 28 Aug 2024 06:11:03 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: 16-bit store instructions &c?
Message-ID: <3ca4590a-8256-42d1-89ca-f337ae6f755c@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello, Arnd,

You know how it goes, give them an inch...

I did get a request for 16-bit xchg(), but last I checked, Linux still
supports some systems that do not have 16-bit store instructions.

Could you please let me know whether this is still the case?

							Thanx, Paul

