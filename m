Return-Path: <linux-arch+bounces-12336-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE3CAD7F5C
	for <lists+linux-arch@lfdr.de>; Fri, 13 Jun 2025 02:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F2863AF887
	for <lists+linux-arch@lfdr.de>; Fri, 13 Jun 2025 00:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9323C2FA;
	Fri, 13 Jun 2025 00:05:45 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFC63C3C;
	Fri, 13 Jun 2025 00:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749773145; cv=none; b=V14HXABFgJRnrw5bz/t4tUdmxGduvIT6x+KA7ukmVRqrhGAu5mXY9anrTgdbC3OfgqJiw2r46cDaU2DWe8UV4mG3D23kWtjllEdLSXPnLPpophIfsge6nEOH+iXC9ry2LyIxtTjwtI4vbempXSjaYeyxvGPzj7+wyotGsvAWIGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749773145; c=relaxed/simple;
	bh=Kt7Accb+8i/pjZpVG85NE9OT4gOLDzlzRlWVvUOQv38=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WAHpDP1YU4t9tjOFpTmQSK78O5EegxWhLgun+2R0v6VX6A+/mFNy1oPW45wpj0eMnOoEGTr6GiaUFUpt4g0aQcVTy3y02oA0Z3oSnBk8w/LXUzfFckBqss9S33Tzwd7H3iJau8nwBKyKCUljQ2iw5NDfe7NgRhKy8U/kj1uI0C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 28704803FC;
	Fri, 13 Jun 2025 00:05:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 1ECD46000C;
	Fri, 13 Jun 2025 00:05:39 +0000 (UTC)
Date: Thu, 12 Jun 2025 20:05:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 llvm@lists.linux.dev
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada
 <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas
 Schier <nicolas.schier@linux.dev>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 0/5] tracepoints: Add warnings for unused tracepoints
 and trace events
Message-ID: <20250612200538.004283c5@batman.local.home>
In-Reply-To: <20250612235827.011358765@goodmis.org>
References: <20250612235827.011358765@goodmis.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 1ECD46000C
X-Stat-Signature: zdf4b9343ct3rz8p7oiftf7by5wymr9z
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX182rpPACDbXiIIR169ho7pJ1BHFcNrKlGw=
X-HE-Tag: 1749773139-898727
X-HE-Meta: U2FsdGVkX18LiKy4WkjPLf1kuMnEFrGs1hRhmTl/iYvGYdOPKZHoPnY8OV2lr/+jsGUYxNcviqUvI2Fc6oTpWpXF3nf7lAPwHpSXbI7hzw1Oo9MdDmt2jp9Akz5X9C2pOOY4MyevT3r1QFEQThSNnq4Uayd+R//FnxUZdVnWL+LnQCwFjixcwcOMxBc0dN5cIwuQQ4eWXq3LkrIhh3qRCwyMHhA3RClrgqkQyEdJwYUvLUJgjw7hK+D083fv9jHV6Onj0ILajZ0RvnP2NZ7SlP2n6QQq+hPIyXAhSra1AjXPoGjXXE+fw27xQ0mdDm4Y9V2lOBmkdUPgV5xzWpx6v2BMSeF71YiFUNg74KmJKBKyBm7w00l8D8r/3O+HapSj

On Thu, 12 Jun 2025 19:58:27 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> The third patch updates sorttable to work for arm64 when compiled with gcc. As
> gcc's arm64 build doesn't put addresses in their section but saves them off in
> the RELA sections. This mostly takes the work done that was needed to do the
> mcount sorting at boot up on arm64.

FYI, I built this on every architecture with their default config and
every architecture that supports tracing reported unused events. Mostly
they were the same, but depending on the defconfig it gave different
output.

-- Steve

