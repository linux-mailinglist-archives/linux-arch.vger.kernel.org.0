Return-Path: <linux-arch+bounces-9259-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B909E5C21
	for <lists+linux-arch@lfdr.de>; Thu,  5 Dec 2024 17:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C520828902F
	for <lists+linux-arch@lfdr.de>; Thu,  5 Dec 2024 16:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EE1227B8F;
	Thu,  5 Dec 2024 16:50:52 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33C4226EC1;
	Thu,  5 Dec 2024 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733417452; cv=none; b=MYeAo52kFjFJlg6IzSvxkOZFcUPpa32Oz1YKkSg7YdhkxlGtu3O2isRlzUV78Z2GcfbCrYv+OgXQsR5ysgE87BFxs21ysQ2pZ5V4WyHYM2tQO+nToTl7D5NPV0q7SfwVKyOGA+Wm1ypBzjwuQLJKBz5/Dty6fkPd/MIrYUwFpYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733417452; c=relaxed/simple;
	bh=MzsLOHp7yqamHtBjlY0//l7fYt9alEw4xvhKnqwpJSA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CXQP50KOBkouVPAH6uP5Kfzhyr9iQVFvERhtQtBdU2c0zaRVyNGh48htEMR6Xg8a6ZK/597l1xqxPf/5iqr8FQ4Vc0TTip07mTfEpAhbj98phcZA7qrVds5tjv/iZd8MNz9EiwD1A/2if2KHxBQgLfc+hkfjzpH42E74ZHzEl28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id A6D2B1615AF;
	Thu,  5 Dec 2024 16:33:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id AE1426000F;
	Thu,  5 Dec 2024 16:33:20 +0000 (UTC)
Message-ID: <b0e9c31f81a368375541d16dbc88783f614ede6d.camel@perches.com>
Subject: Re: [PATCH 1/3] checkpatch: Update reference to include/asm-<arch>
From: Joe Perches <joe@perches.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Oleg Nesterov	
 <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Yury Norov	
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Andy
 Whitcroft <apw@canonical.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn	 <lukas.bulwahn@gmail.com>, Masahiro Yamada
 <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas
 Schier <nicolas@fjasle.eu>
Cc: linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 05 Dec 2024 08:33:34 -0800
In-Reply-To: <2c4a75726a976d117055055b68a31c40dcab044e.1733404444.git.geert+renesas@glider.be>
References: <cover.1733404444.git.geert+renesas@glider.be>
	 <2c4a75726a976d117055055b68a31c40dcab044e.1733404444.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: AE1426000F
X-Rspamd-Server: rspamout05
X-Stat-Signature: weqz4yxs4rsngq31x84j563afb4cz9gr
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+iMORYG7c95cEvLW/2KGmp8+SUheDXAY0=
X-HE-Tag: 1733416400-712928
X-HE-Meta: U2FsdGVkX1/GrCFAVV1JCrdbvojW2peO21Wb4xE8Ls27bAQ65RvSuEMjGsVPAXyW7MQlWXnwLov7Ti/84i/FpUH64Gw6IDjLmriSHPYQcsNg+sDFqF7Qg1xNxflh8fS6Xn3s3D2A4Ek2XT6VQ9slbDhWhXblyARqXcs7Er2ZPNHB90HG6MKPTjjdNfq3xc3wM3o69kJZDluoEKVbHx5lGwS8hD78DEekrWh27Vq3dlcpjhycZCsDyuTc/MTcwfhRML89zzXWDs8xpH35ewGSv+R3Iw4/RjzpRpAksavpg2dIIvSVv/VVTiocHTr772iE

On Thu, 2024-12-05 at 14:20 +0100, Geert Uytterhoeven wrote:
> "include/asm-<arch>" was replaced by "arch/<arch>/include/asm" a long
> time ago.

Thanks.

>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 9eed3683ad76caff..dbb9c3c6fe30f906 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2875,7 +2875,7 @@ sub process {
> =20
>  			if ($realfile =3D~ m@^include/asm/@) {
>  				ERROR("MODIFIED_INCLUDE_ASM",
> -				      "do not modify files in include/asm, change architecture speci=
fic files in include/asm-<architecture>\n" . "$here$rawline\n");
> +				      "do not modify files in include/asm, change architecture speci=
fic files in arch/<architecture>/include/asm\n" . "$here$rawline\n");
>  			}
>  			$found_file =3D 1;
>  		}


