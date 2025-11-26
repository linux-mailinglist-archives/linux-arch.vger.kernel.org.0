Return-Path: <linux-arch+bounces-15083-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CBFC892D8
	for <lists+linux-arch@lfdr.de>; Wed, 26 Nov 2025 11:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 981DA4EB9A8
	for <lists+linux-arch@lfdr.de>; Wed, 26 Nov 2025 10:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25852F83BC;
	Wed, 26 Nov 2025 10:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDUJPW63"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB952E54CC;
	Wed, 26 Nov 2025 10:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764151378; cv=none; b=ewEIN5EF90JdA4uHfFgUGzjPPg/O29xHh61QpgMw3D+Et1OdBhOz9PDZB4BndbZWN0tgqBeShYoWe6RDBIxGzV8FNDnulNqKPo9Ht6NVLpQp5sMRNg8Lote+qGxwMhWFfoYgxByC2rnHnnhqXnB7V6O4TgZ/7yjJESfotGzYwr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764151378; c=relaxed/simple;
	bh=xXqrJ8HIf4HVKSwlHfvo9uZclOBEXwWRwuyFr3etAuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZycCwP5+jc9jZ6rrTK3Bda2NKDEwshbA9M6xarkj6zbnIj86ar5M872gMmzvTp4OwgigZJ24FN9Uo8AxSkx7P4lkZ+HnJO1k9bJ8Gju+MGLGsziFOoIzFBo5lrwqiNtG+04zBfsA5mWHNCdjM/2Bkay1aMqa0IKTsMKK6X/i3E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDUJPW63; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A107C113D0;
	Wed, 26 Nov 2025 10:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764151378;
	bh=xXqrJ8HIf4HVKSwlHfvo9uZclOBEXwWRwuyFr3etAuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mDUJPW63F05Xi9Y5/6dzbh7U30QKG3Y01WmA/wIbiTZght2Tbvc6aKKW9G3n2eNdN
	 KUzsEmRda97EPGv+1LP6eGFO+bMCi1FsJK9YjyPO7LZ+CTbI/0hFUy+DhZFsE6c/qb
	 pWZEGlBYFi2N7yfN2xN5mF+5B14DXDl0zSkGqf59lU92vqIibm7iIIYOHJpDnU/u4Y
	 orr6NGWHXKzjgyHxJbg8ep4iElE/xB3Y/xe+rvyWAPkZjwJR3LI8o+BfB+Hm7qYZ/u
	 iGESbT5Dsv+RuzoKFwN4lsTEi29bI9XFTHzVuxmlrPyF6GKcU9LBLatv/sZ6QM9gMO
	 ddNAvxlLGbA6w==
Date: Wed, 26 Nov 2025 10:02:51 +0000
From: Simon Horman <horms@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v7 5/5] selftests: drv-net: devmem: add
 autorelease tests
Message-ID: <aSbQS5HqMkfDhktz@horms.kernel.org>
References: <20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-0-1abc8467354c@meta.com>
 <20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-5-1abc8467354c@meta.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-5-1abc8467354c@meta.com>

On Wed, Nov 19, 2025 at 07:37:12PM -0800, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Add tests cases that check the autorelease modes (on and off).  The new
> tests are the same as the old ones, but just pass a flag to ncdevmem to
> select the autorelease mode.
> 
> Only for RX tests is autorelease checked, as the autorelease ncdevmem
> flag is unused in the TX case and doesn't apply to TX bind operations.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> ---
> Note: I tested successfully with kperf, but I'm troubleshooting
> some mlx5 issues with ncdevmem so this patch, though simple, is not
> fully validated. Will respond to this thread when solve the issue.
> 
> Changes in v7:
> - use autorelease netlink
> - remove sockopt tests
> ---
>  tools/testing/selftests/drivers/net/hw/devmem.py  | 22 ++++++++++++++++++++--
>  tools/testing/selftests/drivers/net/hw/ncdevmem.c | 19 +++++++++++++------
>  2 files changed, 33 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
> index 45c2d49d55b6..dddb9d77cb28 100755
> --- a/tools/testing/selftests/drivers/net/hw/devmem.py
> +++ b/tools/testing/selftests/drivers/net/hw/devmem.py
> @@ -25,7 +25,23 @@ def check_rx(cfg) -> None:
>  
>      port = rand_port()
>      socat = f"socat -u - TCP{cfg.addr_ipver}:{cfg.baddr}:{port},bind={cfg.remote_baddr}:{port}"
> -    listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.addr} -p {port} -c {cfg.remote_addr} -v 7"
> +    listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.addr} -p {port} -c {cfg.remote_addr} -v 7 -a 0"
> +
> +    with bkg(listen_cmd, exit_wait=True) as ncdevmem:
> +        wait_port_listen(port)
> +        cmd(f"yes $(echo -e \x01\x02\x03\x04\x05\x06) | \
> +            head -c 1K | {socat}", host=cfg.remote, shell=True)
> +
> +    ksft_eq(ncdevmem.ret, 0)
> +
> +
> +@ksft_disruptive
> +def check_rx_autorelease(cfg) -> None:
> +    require_devmem(cfg)
> +
> +    port = rand_port()
> +    socat = f"socat -u - TCP{cfg.addr_ipver}:{cfg.baddr}:{port},bind={cfg.remote_baddr}:{port}"
> +    listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.addr} -p {port} -c {cfg.remote_addr} -v 7 -a 1"
>  
>      with bkg(listen_cmd, exit_wait=True) as ncdevmem:
>          wait_port_listen(port)
> @@ -68,7 +84,9 @@ def main() -> None:
>          cfg.bin_local = path.abspath(path.dirname(__file__) + "/ncdevmem")
>          cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
>  
> -        ksft_run([check_rx, check_tx, check_tx_chunks],
> +        ksft_run([check_rx, check_rx_autorelease,
> +                  check_tx, check_tx_autorelease,
> +                  check_tx_chunks, check_tx_chunks_autorelease],
>                   args=(cfg, ))
>      ksft_exit()
>  

Hi Bobby,

Sorry if this is a duplicate: I drafted this before bit AFAIKT
I accidently hit the worng key and deleted it.

I see that check_rx_autorelease is implemented above,
but I don't see an implementatoin of check_tx_autorelease
or check_tx_chunks_autorelease. Perhaps they should be added too?

Flagged by pylint and ruff.
Also confirmed by running devmem.py using vng (possibly incorrectly).


This patch also adds some other pylint warnings, about missing
documentation and lines that are too long. Although there are
already instances of the same warning in this file. So I'm not
sure how we should feel about that.

...

